import 'package:flutter_project/features/task/domain/providers/task_provider.dart';
import 'package:flutter_project/features/task/presentation/providers/state/task_notifier.dart';
import 'package:flutter_project/features/task/presentation/providers/state/task_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Map<String, StateNotifierProvider<TaskNotifier, TaskState>>
    taskNotifierProviders = {};

StateNotifierProvider<TaskNotifier, TaskState> getTaskNotifierProvider(
    String taskStatus) {
  if (taskNotifierProviders.containsKey(taskStatus)) {
    return taskNotifierProviders[taskStatus]!;
  } else {
    final notifierProvider = StateNotifierProvider<TaskNotifier, TaskState>(
      (ref) {
        final repository = ref.watch(taskRepositoryProvider);
        return TaskNotifier(repository, taskStatus)..fetchTask();
      },
    );
    taskNotifierProviders[taskStatus] = notifierProvider;
    return notifierProvider;
  }
}
