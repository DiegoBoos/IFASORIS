part of 'sync_bloc.dart';

abstract class SyncEvent extends Equatable {
  const SyncEvent();

  @override
  List<Object> get props => [];
}

class SyncStarted extends SyncEvent {
  final UsuarioEntity usuario;
  final List<String> tablesNames;

  const SyncStarted(this.usuario, this.tablesNames);
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
  final List<SyncLogEntity> syncLog;

  const SyncLog(this.syncLog);
}
