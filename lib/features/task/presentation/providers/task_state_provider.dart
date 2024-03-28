import 'package:flutter_project/features/task/domain/providers/task_provider.dart';
import 'package:flutter_project/features/task/presentation/providers/state/task_notifier.dart';
import 'package:flutter_project/features/task/presentation/providers/state/task_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StateNotifierProvider<TaskNotifier, TaskState> getTaskNotifierProvider(
    String taskStatus) {
  return StateNotifierProvider<TaskNotifier, TaskState>(
    (ref) {
      final repository = ref.watch(taskRepositoryProvider);
      return TaskNotifier(repository, taskStatus)..fetchTask();
    },
  );
}
