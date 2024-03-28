import 'package:flutter_project/shared/domain/models/either.dart';
import 'package:flutter_project/shared/domain/models/task_paginated_response.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';

abstract class TaskRepository {
  Future<Either<AppException, TaskPaginatedResponse>> getTasks({
    required int offset,
    required int limit,
    required String sortBy,
    required bool isAsc,
    required String status,
  });
}
