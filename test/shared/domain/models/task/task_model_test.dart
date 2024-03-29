import 'package:flutter_project/shared/domain/models/task/task_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/dashboard/dummy_tasklist.dart';
import '../../../../fixtures/data/task_response.dart';

void main() {
  group(
    'TaskModel Test\n',
    () {
      test('Should parse Task from json', () {
        expect(Task.fromJson(taskMap), ktestTaskList[1]);
      });

      test('Should return json from task', () {
        expect(ktestTaskList[0].toJson(), taskMap);
      });
      test('Should return string of task', () {
        expect(ktestTaskList[0].toJson(), isA<Map<String, dynamic>>());
      });
    },
  );
}
