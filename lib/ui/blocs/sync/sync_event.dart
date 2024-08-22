part of 'sync_bloc.dart';

abstract class SyncEvent extends Equatable {
  const SyncEvent();

  @override
  List<Object> get props => [];
}

class InitSync extends SyncEvent {}

class SyncStarted extends SyncEvent {
  final User user;
  final String type;

  const SyncStarted(this.user, this.type);
}

class Downloading extends SyncEvent {
  final SyncProgressModel syncProgress;

  const Downloading(this.syncProgress);
}

class SyncPercentageChanged extends SyncEvent {
  final SyncProgressModel syncProgress;

  const SyncPercentageChanged(this.syncProgress);

  @override
  List<Object> get props => [syncProgress];
}

class SyncIncrementChanged extends SyncEvent {
  final SyncProgressModel syncProgress;

  const SyncIncrementChanged(this.syncProgress);

  @override
  List<Object> get props => [syncProgress];
}

class SyncError extends SyncEvent {
  final String message;

  const SyncError(this.message);
}

class SyncLog extends SyncEvent {
  final List<SyncLog> syncLog;

  const SyncLog(this.syncLog);
}
