import 'package:flutter_project/shared/domain/models/parse_response.dart';
import 'package:flutter_project/shared/domain/models/task/task_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/data/task_response.dart';

void main() {
  test('Should parse response in correct format', () {
    final response =
        ParseResponse<Task>.fromMap(taskListMap(), modifier: Task.fromJson);

    expect(response.data is Task, true);
  });
}
