part of 'collection_sync_manager_cubit.dart';

@freezed
class CollectionSyncManagerState with _$CollectionSyncManagerState {
  const factory CollectionSyncManagerState.disabled() = CollectionSyncDisabled;
  const factory CollectionSyncManagerState.unknown() = CollectionSyncUnknown;
  const factory CollectionSyncManagerState.syncingUnknonw() =
      CollectionSyncingUnknown;
  const factory CollectionSyncManagerState.syncing({
    required int synced,
  }) = CollectionSyncing;
  const factory CollectionSyncManagerState.synced(
      {@Default(false) bool manual,
      @Default(true) triggerReaction}) = CollectionSyncComplete;
  const factory CollectionSyncManagerState.failed(Failure failure) =
      CollectionSyncFailed;
}
