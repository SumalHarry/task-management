import 'package:flutter_project/shared/data/remote/network_service.dart';
import 'package:flutter_project/shared/domain/models/either.dart';
import 'package:flutter_project/shared/domain/models/task_paginated_response.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';

abstract class TaskDataSource {
  Future<Either<AppException, TaskPaginatedResponse>> getTasks({
    required int offset,
    required int limit,
    required String sortBy,
    required bool isAsc,
    required String status,
  });
}

// offset=0&limit=2&sortBy=createdAt&isAsc=true&status=TODO
class TaskRemoteDataSource implements TaskDataSource {
  TaskRemoteDataSource(this.networkService);

  final NetworkService networkService;

  @override
  Future<Either<AppException, TaskPaginatedResponse>> getTasks({
    required int offset,
    required int limit,
    required String sortBy,
    required bool isAsc,
    required String status,
  }) async {
    try {
      final eitherType = await networkService.get(
        '/todo-list',
        queryParameters: {
          'offset': offset,
          'limit': limit,
          'sortBy': sortBy,
          'isAsc': isAsc,
          'status': status,
        },
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final jsonData = response.data;
          final taskResponse =
              TaskPaginatedResponse.fromJson(jsonData, jsonData['tasks'] ?? []);
          return Right(taskResponse);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nTaskRemoteDataSource.getTasks',
        ),
      );
    }
  }
}
