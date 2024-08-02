import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:copycat_base/bloc/app_config_cubit/app_config_cubit.dart';
import 'package:copycat_base/bloc/auth_cubit/auth_cubit.dart';
import 'package:copycat_base/bloc/drive_setup_cubit/drive_setup_cubit.dart';
import 'package:copycat_base/common/failure.dart';
import 'package:copycat_base/common/logging.dart';
import 'package:copycat_base/data/services/google_services.dart';
import 'package:copycat_base/db/clipboard_item/clipboard_item.dart';
import 'package:copycat_base/domain/repositories/clipboard.dart';
import 'package:copycat_base/enums/clip_type.dart';
import 'package:copycat_base/utils/blur_hash.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import "package:universal_io/io.dart";

part 'cloud_persistance_cubit.freezed.dart';
part 'cloud_persistance_state.dart';

@lazySingleton
class CloudPersistanceCubit extends Cubit<CloudPersistanceState> {
  final AuthCubit auth;
  final DriveSetupCubit driveCubit;
  final ClipboardRepository repo;
  final DriveService drive;
  final AppConfigCubit appConfig;
  final String deviceId;

  CloudPersistanceCubit(
    this.auth,
    this.driveCubit,
    this.appConfig,
    @Named("device_id") this.deviceId,
    @Named("cloud") this.repo,
    @Named("google_drive") this.drive,
  ) : super(const CloudPersistanceState.initial());

  Future<void> persist(ClipboardItem item, {int retryCount = 0}) async {
    if (auth.isLocalAuth) return;
    // emit(const CloudPersistanceState.initial());

    if (!appConfig.isSyncEnabled) {
      if (item.userIntent) {
        emit(
          CloudPersistanceState.error(
            const Failure(
              message: "Sync is not enabled",
              code: "sync-not-enabled",
            ),
            item,
            FailedAction.create,
            retryCount: -1,
          ),
        );
      }
      return;
    }

    final userId = auth.userId;
    if (userId == null) return;

    item = item.assignUserId(userId);

    if (item.serverId != null) {
      emit(CloudPersistanceState.updatingItem(item));
      final result = await repo.update(item);
      emit(
        result.fold(
          (l) => CloudPersistanceState.error(
            l,
            item.syncDone(l),
            FailedAction.update,
            retryCount: retryCount,
          ),
          (r) => CloudPersistanceState.saved(r.syncDone()),
        ),
      );
    } else {
      switch (item.type) {
        case ClipItemType.text || ClipItemType.url:
          await _create(item.assignUserId(userId));
        case ClipItemType.media || ClipItemType.file:
          if (!appConfig.isFileSyncEnabled) {
            emit(
              CloudPersistanceState.error(
                const Failure(
                  message: "File and Media Sync is not enabled",
                  code: "file-sync-not-enabled",
                ),
                item,
                FailedAction.create,
                retryCount: -1,
              ),
            );
            return;
          }
          await _uploadAndCreate(
            item.assignUserId(userId),
            retryCount: retryCount,
          );
      }
    }
    return;
  }

  Future<void> _create(ClipboardItem item, {int retryCount = 0}) async {
    emit(CloudPersistanceState.creatingItem(item));
    final result = await repo.create(item);
    emit(
      result.fold(
        (l) => CloudPersistanceState.error(
          l,
          item.syncDone(l),
          FailedAction.create,
          retryCount: retryCount,
        ),
        (r) => CloudPersistanceState.saved(
          r.syncDone(),
          created: true,
        ),
      ),
    );
  }

  Future<String?> _getBlurHashIfNeeded(ClipboardItem item) async {
    if (item.fileMimeType == null ||
        !item.fileMimeType!.startsWith("image/") ||
        item.imgBlurHash != null ||
        item.localPath == null) return null;

    final blurHash = await getBlurHash(item.localPath!);
    return blurHash;
  }

  Future<void> _uploadAndCreate(
    ClipboardItem item, {
    int retryCount = 0,
  }) async {
    if (!appConfig.canUploadFile(item.fileSize!) && !item.userIntent) {
      logger.i("Auto upload is disabled for files over the limit.");
      emit(
        CloudPersistanceState.error(
          const Failure(
            message: "Auto upload is disabled for files over the limit.",
            code: "auto-upload-restriction",
          ),
          item,
          FailedAction.upload,
          retryCount: -1,
        ),
      );
      return;
    }

    emit(
      CloudPersistanceState.uploadingFile(
        item.copyWith(uploading: true)..applyId(item),
      ),
    );
    final userId = auth.userId;

    if (userId == null) {
      emit(
        CloudPersistanceState.error(
          authFailure,
          item.syncDone(authFailure),
          FailedAction.create,
          retryCount: retryCount,
        ),
      );
      return;
    }

    final accessToken = await driveCubit.accessToken;

    if (accessToken == null) {
      emit(CloudPersistanceState.error(
        frequentSyncing,
        item.syncDone(frequentSyncing),
        FailedAction.upload,
        retryCount: -1,
      ));
      return;
    }

    drive.accessToken = accessToken;

    final results = await Future.wait([
      drive.upload(
        item.assignUserId(userId),
        onProgress: (uploaded, total) {
          emit(
            CloudPersistanceState.uploadingFile(
              item.copyWith(
                uploading: true,
                uploadProgress: uploaded / total,
              )..applyId(item),
            ),
          );
        },
      ),
      _getBlurHashIfNeeded(item)
    ]);

    ClipboardItem updatedItem = results[0] as ClipboardItem;
    final blurhash = results[1] as String?;

    if (blurhash != null) {
      updatedItem = updatedItem.copyWith(imgBlurHash: blurhash)
        ..applyId(updatedItem);
    }

    if (updatedItem.driveFileId != null) {
      await _create(updatedItem, retryCount: retryCount);
    }
  }

  Future<void> delete(ClipboardItem item, {int retryCount = 0}) async {
    emit(CloudPersistanceState.deletingItem(item));
    drive.cancelOperation(item);
    if (item.driveFileId != null) {
      final accessToken = await driveCubit.accessToken;

      if (accessToken == null) {
        emit(CloudPersistanceState.error(
          frequentSyncing,
          item.syncDone(frequentSyncing),
          FailedAction.upload,
          retryCount: -1,
        ));
        return;
      }

      drive.accessToken = accessToken;
      await drive.delete(item);

      item = item.copyWith(driveFileId: null)..applyId(item);
    }

    if (item.serverId == null) {
      emit(
        CloudPersistanceState.deletedItem(
          item.copyWith(lastSynced: null)..applyId(item),
        ),
      );
      return;
    }

    item = item.copyWith(deviceId: deviceId)..applyId(item);
    final result = await repo.delete(item);

    result.fold(
      (l) => emit(CloudPersistanceState.error(
        l,
        item,
        FailedAction.delete,
        retryCount: retryCount,
      )),
      (r) => emit(
        CloudPersistanceState.deletedItem(
          item.copyWith(
            serverId: null,
            lastSynced: null,
          )..applyId(item),
        ),
      ),
    );
  }

  Future<void> download(
    ClipboardItem item, {
    int retryCount = 0,
  }) async {
    final isDownloading = drive.isDownloading(item);
    if (isDownloading) return;

    if (item.localPath != null) {
      final exists = await File(item.localPath!).exists();
      if (exists) return;
    }

    emit(
      CloudPersistanceState.downloadingFile(
        item.copyWith(downloading: true)..applyId(item),
      ),
    );
    final userId = auth.userId;

    if (userId == null) {
      emit(CloudPersistanceState.error(
        authFailure,
        item.syncDone(authFailure),
        FailedAction.download,
        retryCount: retryCount,
      ));
      return;
    }

    final accessToken = await driveCubit.accessToken;

    if (accessToken == null) {
      emit(CloudPersistanceState.error(
        frequentSyncing,
        item.syncDone(frequentSyncing),
        FailedAction.download,
        retryCount: -1,
      ));
      return;
    }

    drive.accessToken = accessToken;
    final updatedItem = await drive.download(
      item.assignUserId(userId),
    );
    await persist(updatedItem);
  }
}