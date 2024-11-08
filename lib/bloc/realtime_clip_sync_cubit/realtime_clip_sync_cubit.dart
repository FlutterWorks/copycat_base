import 'dart:async';

import 'package:atom_event_bus/atom_event_bus.dart';
import 'package:bloc/bloc.dart';
import 'package:copycat_base/common/events.dart';
import 'package:copycat_base/common/logging.dart';
import 'package:copycat_base/db/clipboard_item/clipboard_item.dart';
import 'package:copycat_base/domain/repositories/clip_collection.dart';
import 'package:copycat_base/domain/repositories/clipboard.dart';
import 'package:copycat_base/domain/services/cross_sync_listener.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'realtime_clip_sync_cubit.freezed.dart';
part 'realtime_clip_sync_state.dart';

@injectable
class RealtimeClipSyncCubit extends Cubit<RealtimeClipSyncState> {
  final ClipCrossSyncListener listener;
  final ClipboardRepository clipRepo;
  final ClipCollectionRepository collectionRepo;

  StreamSubscription? statusSubscription, changeSubscription;

  RealtimeClipSyncCubit(
    this.listener,
    @Named("offline") this.clipRepo,
    this.collectionRepo,
  ) : super(const RealtimeClipSyncState.initial());

  void _clearSubs() {
    changeSubscription?.cancel();
    statusSubscription?.cancel();
  }

  void subscribe() {
    _clearSubs();
    statusSubscription = listener.onStatusChange.listen(onStatusChange);
    changeSubscription = listener.onChange.listen(onSync);
    listener.start();
  }

  void unsubscribe() {
    _clearSubs();
    listener.stop();
  }

  void onStatusChange(CrossSyncStatusEvent event) {
    final (status, obj) = event;
    logger.w("Status Change");
    logger.w(status);
    logger.w(obj);
  }

  Future<void> onSync(CrossSyncEvent<ClipboardItem> event) async {
    var (type, item) = event;
    logger.w("Sync Change");
    logger.w(type);
    logger.w(item);

    if (item.serverCollectionId != null) {
      final collection =
          await collectionRepo.get(serverId: item.serverCollectionId);

      collection.fold((failure) {}, (collection) {
        if (collection != null) {
          item = item.copyWith(collectionId: collection.id);
        }
      });
    }

    final result = await clipRepo.updateOrCreate(item);
    result.fold((failure) {}, (item) {
      final eventPayload = clipboardSyncItemEvent.createPayload((type, item));
      EventBus.emit(eventPayload);
    });
  }

  @override
  Future<void> close() {
    unsubscribe();
    return super.close();
  }
}