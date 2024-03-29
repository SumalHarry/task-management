import 'package:flutter_project/shared/domain/models/paginated_response.dart';
import 'package:flutter_project/shared/domain/models/parse_response.dart';
import 'package:flutter_project/shared/domain/models/task/task_model.dart';

import '../data/task_response.dart';

Map<String, dynamic> ktestTaskResponse = taskListMap();

PaginatedResponse ktestPaginatedResponse({int? pageNumber}) =>
    PaginatedResponse.fromJson(taskListMap(pageNumber: pageNumber),
        taskListMap(pageNumber: pageNumber)['tasks']);

final ktestParseResponse = ktestPaginatedResponse().data.map(
      (e) => ParseResponse<Task>.fromMap(e, modifier: Task.fromJson),
    );
final List<Task> ktestTaskList =
    (taskListMap()['tasks'] as List).map((e) => Task.fromJson(e)).toList();

final ktestProduct = Task.fromJson({});
