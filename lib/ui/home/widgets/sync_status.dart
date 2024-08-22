import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../blocs/sync/sync_bloc.dart';
import 'sync_dialog.dart';
import 'sync_progress.dart';

class SyncStatus extends StatelessWidget {
  final User currentUser;
  final String type;

  const SyncStatus({super.key, required this.currentUser, required this.type});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<SyncBloc, SyncState>(builder: (context, state) {
        if (state is SyncDownloading || state is SyncPercentageInProgress) {
          return SyncProgress(
            title:
                '${state.syncProgressModel.title} ${state.syncProgressModel.percent}%',
            user: currentUser,
            type: type,
          );
        }
        if (state is SyncIncrementInProgress) {
          return SyncProgress(
            title:
                '${state.syncProgressModel.title} ${state.syncProgressModel.counter} / ${state.syncProgressModel.total}',
            user: currentUser,
            type: type,
          );
        }
        return SyncDialog(type: type);
      }),
    );
  }
}
