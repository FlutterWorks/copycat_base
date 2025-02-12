//@GeneratedMicroModule;CopycatBasePackageModule;package:copycat_base/di/di.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:android_background_clipboard/android_background_clipboard.dart'
    as _i565;
import 'package:copycat_base/bloc/android_bg_clipboard_cubit/android_bg_clipboard_cubit.dart'
    as _i433;
import 'package:copycat_base/bloc/app_config_cubit/app_config_cubit.dart'
    as _i411;
import 'package:copycat_base/bloc/auth_cubit/auth_cubit.dart' as _i630;
import 'package:copycat_base/bloc/clip_collection_cubit/clip_collection_cubit.dart'
    as _i402;
import 'package:copycat_base/bloc/clip_sync_manager_cubit/clip_sync_manager_cubit.dart'
    as _i84;
import 'package:copycat_base/bloc/clipboard_cubit/clipboard_cubit.dart'
    as _i189;
import 'package:copycat_base/bloc/cloud_persistance_cubit/cloud_persistance_cubit.dart'
    as _i691;
import 'package:copycat_base/bloc/collection_clips_cubit/collection_clips_cubit.dart'
    as _i1054;
import 'package:copycat_base/bloc/collection_sync_manager_cubit/collection_sync_manager_cubit.dart'
    as _i988;
import 'package:copycat_base/bloc/drive_setup_cubit/drive_setup_cubit.dart'
    as _i746;
import 'package:copycat_base/bloc/event_bus_cubit/event_bus_cubit.dart'
    as _i236;
import 'package:copycat_base/bloc/offline_persistance_cubit/offline_persistance_cubit.dart'
    as _i768;
import 'package:copycat_base/bloc/realtime_clip_sync_cubit/realtime_clip_sync_cubit.dart'
    as _i685;
import 'package:copycat_base/bloc/realtime_collection_sync_cubit/realtime_collection_sync_cubit.dart'
    as _i141;
import 'package:copycat_base/bloc/selected_clips_cubit/selected_clips_cubit.dart'
    as _i443;
import 'package:copycat_base/bloc/window_action_cubit/window_action_cubit.dart'
    as _i617;
import 'package:copycat_base/data/repositories/analytics.dart' as _i55;
import 'package:copycat_base/data/repositories/app_config.dart' as _i228;
import 'package:copycat_base/data/repositories/clip_collection.dart' as _i834;
import 'package:copycat_base/data/repositories/clipboard.dart' as _i122;
import 'package:copycat_base/data/repositories/restoration_status.dart'
    as _i491;
import 'package:copycat_base/data/repositories/sync_clipboard.dart' as _i421;
import 'package:copycat_base/data/services/clipboard_service.dart' as _i354;
import 'package:copycat_base/data/services/google_drive_service.dart' as _i872;
import 'package:copycat_base/data/services/google_services.dart' as _i1054;
import 'package:copycat_base/data/sources/clip_collection/local_source.dart'
    as _i799;
import 'package:copycat_base/data/sources/clipboard/local_source.dart' as _i397;
import 'package:copycat_base/data/sources/restoration_status/local_source.dart'
    as _i1043;
import 'package:copycat_base/db/clip_collection/clipcollection.dart' as _i531;
import 'package:copycat_base/di/modules.dart' as _i50;
import 'package:copycat_base/domain/repositories/analytics.dart' as _i860;
import 'package:copycat_base/domain/repositories/app_config.dart' as _i854;
import 'package:copycat_base/domain/repositories/auth.dart' as _i281;
import 'package:copycat_base/domain/repositories/clip_collection.dart' as _i625;
import 'package:copycat_base/domain/repositories/clipboard.dart' as _i72;
import 'package:copycat_base/domain/repositories/drive_credential.dart'
    as _i447;
import 'package:copycat_base/domain/repositories/restoration_status.dart'
    as _i957;
import 'package:copycat_base/domain/repositories/sync_clipboard.dart' as _i106;
import 'package:copycat_base/domain/services/cross_sync_listener.dart' as _i159;
import 'package:copycat_base/domain/sources/clip_collection.dart' as _i569;
import 'package:copycat_base/domain/sources/clipboard.dart' as _i191;
import 'package:copycat_base/domain/sources/restoration_status.dart' as _i934;
import 'package:copycat_base/domain/sources/sync_clipboard.dart' as _i903;
import 'package:injectable/injectable.dart' as _i526;
import 'package:isar/isar.dart' as _i338;
import 'package:tiny_storage/tiny_storage.dart' as _i829;

class CopycatBasePackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) async {
    final registerModule = _$RegisterModule();
    gh.factory<_i443.SelectedClipsCubit>(() => _i443.SelectedClipsCubit());
    gh.factory<_i617.WindowActionCubit>(() => _i617.WindowActionCubit());
    await gh.singletonAsync<_i829.TinyStorage>(
      () => registerModule.localCache(),
      preResolve: true,
    );
    gh.singleton<_i354.ClipboardService>(() => _i354.ClipboardService());
    gh.singleton<_i236.EventBusCubit>(() => _i236.EventBusCubit());
    await gh.lazySingletonAsync<_i338.Isar>(
      () => registerModule.db,
      preResolve: true,
      dispose: _i50.closeIsarDb,
    );
    gh.lazySingleton<_i565.AndroidBackgroundClipboard>(
        () => registerModule.bgService);
    gh.lazySingleton<_i872.GoogleOAuth2Service>(
        () => _i872.GoogleOAuth2Service());
    gh.lazySingleton<_i854.AppConfigRepository>(
        () => _i228.AppConfigRepositoryImpl(gh<_i338.Isar>()));
    gh.lazySingleton<_i860.AnalyticsRepository>(
        () => const _i55.AnalyticsRepositoryImpl());
    gh.lazySingleton<_i934.RestorationStatusSource>(
        () => _i1043.RestorationStatusSourceImpl(db: gh<_i338.Isar>()));
    gh.lazySingleton<_i106.SyncRepository>(() => _i421.SyncRepositoryImpl(
        gh<_i903.SyncClipboardSource>(instanceName: 'remote')));
    gh.lazySingleton<_i1054.DriveService>(
      () => _i872.GoogleDriveService(),
      instanceName: 'google_drive',
    );
    gh.singleton<_i411.AppConfigCubit>(
        () => _i411.AppConfigCubit(gh<_i854.AppConfigRepository>()));
    await gh.factoryAsync<String>(
      () => registerModule.deviceId(gh<_i829.TinyStorage>()),
      instanceName: 'device_id',
      preResolve: true,
    );
    gh.lazySingleton<_i72.ClipboardRepository>(
      () => _i122.ClipboardRepositoryCloudImpl(
          gh<_i191.ClipboardSource>(instanceName: 'remote')),
      instanceName: 'remote',
    );
    gh.singleton<_i630.AuthCubit>(() => _i630.AuthCubit(
          gh<_i281.AuthRepository>(),
          gh<_i829.TinyStorage>(),
          gh<_i860.AnalyticsRepository>(),
        ));
    gh.lazySingleton<_i191.ClipboardSource>(
      () => _i397.LocalClipboardSource(
        gh<_i338.Isar>(),
        gh<String>(instanceName: 'device_id'),
      ),
      instanceName: 'local',
    );
    gh.lazySingleton<_i569.ClipCollectionSource>(
      () => _i799.LocalClipCollectionSource(
        gh<_i338.Isar>(),
        gh<String>(instanceName: 'device_id'),
      ),
      instanceName: 'local',
    );
    gh.lazySingleton<_i957.RestorationStatusRepository>(() =>
        _i491.RestorationStatusRepositoryImpl(
            gh<_i934.RestorationStatusSource>()));
    gh.lazySingleton<_i746.DriveSetupCubit>(() => _i746.DriveSetupCubit(
          gh<_i447.DriveCredentialRepository>(),
          gh<_i1054.DriveService>(instanceName: 'google_drive'),
        ));
    gh.lazySingleton<_i691.CloudPersistanceCubit>(
        () => _i691.CloudPersistanceCubit(
              gh<_i630.AuthCubit>(),
              gh<_i746.DriveSetupCubit>(),
              gh<_i411.AppConfigCubit>(),
              gh<String>(instanceName: 'device_id'),
              gh<_i72.ClipboardRepository>(instanceName: 'remote'),
            ));
    gh.lazySingleton<_i72.ClipboardRepository>(
      () => _i122.ClipboardRepositoryOfflineImpl(
          gh<_i191.ClipboardSource>(instanceName: 'local')),
      instanceName: 'local',
    );
    gh.lazySingleton<_i768.OfflinePersistenceCubit>(
        () => _i768.OfflinePersistenceCubit(
              gh<_i630.AuthCubit>(),
              gh<_i72.ClipboardRepository>(instanceName: 'local'),
              gh<_i354.ClipboardService>(),
              gh<_i411.AppConfigCubit>(),
              gh<_i860.AnalyticsRepository>(),
              gh<String>(instanceName: 'device_id'),
            ));
    gh.lazySingleton<_i625.ClipCollectionRepository>(
        () => _i834.ClipCollectionRepositoryImpl(
              gh<_i569.ClipCollectionSource>(instanceName: 'remote'),
              gh<_i569.ClipCollectionSource>(instanceName: 'local'),
            ));
    gh.factory<_i685.RealtimeClipSyncCubit>(() => _i685.RealtimeClipSyncCubit(
          gh<_i159.ClipCrossSyncListener>(),
          gh<_i236.EventBusCubit>(),
          gh<_i72.ClipboardRepository>(instanceName: 'local'),
          gh<_i625.ClipCollectionRepository>(),
        ));
    gh.lazySingleton<_i402.ClipCollectionCubit>(() => _i402.ClipCollectionCubit(
          gh<_i236.EventBusCubit>(),
          gh<_i630.AuthCubit>(),
          gh<_i625.ClipCollectionRepository>(),
          gh<String>(instanceName: 'device_id'),
        ));
    gh.factory<_i988.CollectionSyncManagerCubit>(
        () => _i988.CollectionSyncManagerCubit(
              gh<_i236.EventBusCubit>(),
              gh<_i106.SyncRepository>(),
              gh<_i402.ClipCollectionCubit>(),
              gh<_i625.ClipCollectionRepository>(),
              gh<String>(instanceName: 'device_id'),
            ));
    gh.factory<_i189.ClipboardCubit>(() => _i189.ClipboardCubit(
          gh<_i236.EventBusCubit>(),
          gh<_i72.ClipboardRepository>(instanceName: 'local'),
        ));
    gh.factoryParam<_i1054.CollectionClipsCubit, _i531.ClipCollection, dynamic>(
        (
      collection,
      _,
    ) =>
            _i1054.CollectionClipsCubit(
              gh<_i236.EventBusCubit>(),
              gh<_i72.ClipboardRepository>(instanceName: 'local'),
              collection: collection,
            ));
    gh.factory<_i433.AndroidBgClipboardCubit>(
        () => _i433.AndroidBgClipboardCubit(
              gh<_i565.AndroidBackgroundClipboard>(),
              gh<_i236.EventBusCubit>(),
              gh<_i72.ClipboardRepository>(instanceName: 'local'),
              gh<String>(instanceName: 'device_id'),
            ));
    gh.factory<_i141.RealtimeCollectionSyncCubit>(
        () => _i141.RealtimeCollectionSyncCubit(
              gh<_i236.EventBusCubit>(),
              gh<_i159.CollectionCrossSyncListener>(),
              gh<_i625.ClipCollectionRepository>(),
            ));
    gh.factory<_i84.ClipSyncManagerCubit>(() => _i84.ClipSyncManagerCubit(
          gh<_i236.EventBusCubit>(),
          gh<_i106.SyncRepository>(),
          gh<_i402.ClipCollectionCubit>(),
          gh<_i72.ClipboardRepository>(instanceName: 'local'),
          gh<_i625.ClipCollectionRepository>(),
          gh<String>(instanceName: 'device_id'),
        ));
  }
}

class _$RegisterModule extends _i50.RegisterModule {}
