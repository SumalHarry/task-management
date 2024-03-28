import 'package:flutter_project/shared/widgets/app_activity/domain/providers/app_activity_provider.dart';
import 'package:flutter_project/shared/widgets/app_activity/domain/repositories/app_activity_repository.dart';
import 'package:flutter_project/shared/widgets/app_activity/presentation/providers/state/app_activity_notifier.dart';
import 'package:flutter_project/shared/widgets/app_activity/presentation/providers/state/app_activity_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appActivityNotifierProvider =
    StateNotifierProvider<AppActivityNotifier, AppActivityState>((ref) {
  final AppActivityRepository appActivityRepository =
      ref.watch(appActivityRepositoryProvider);
  return AppActivityNotifier(appActivityRepository: appActivityRepository);
});
