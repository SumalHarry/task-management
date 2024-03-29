import 'package:flutter_project/features/task/presentation/providers/state/task_state.dart';
import 'package:flutter_project/shared/domain/models/task/task_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final taskStatus = TaskStatus.TODO.value;

  group('TaskState Test\n', () {
    test('Should update concrete state', () {
      TaskState taskState = TaskState(taskStatus: taskStatus);

      taskState = taskState.copyWith(message: 'TaskConcreteState.loading');

      expect(taskState.message, equals('TaskConcreteState.loading'));
    });
    test('Should return valid String', () {
      TaskState taskState = TaskState(taskStatus: taskStatus);

      expect(taskState.toString(),
          'TaskState(taskList: ${taskState.taskList}, page: ${taskState.page}, hasData: ${taskState.hasData}, state: ${taskState.state}, message: ${taskState.message})');
    });
  });
}
