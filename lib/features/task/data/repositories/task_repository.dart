import 'package:flutter_project/features/task/data/datasource/task_remote_data_source.dart';
import 'package:flutter_project/features/task/domain/repository/task_repository.dart';
import 'package:flutter_project/shared/domain/models/either.dart';
import 'package:flutter_project/shared/domain/models/paginated_response.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';

class TaskRepositoryImpl extends TaskRepository {
  final TaskDataSource taskDatasource;
  TaskRepositoryImpl(this.taskDatasource);

  @override
  Future<Either<AppException, PaginatedResponse>> getTasks({
    required int offset,
    required int limit,
    required String sortBy,
    required bool isAsc,
    required String status,
  }) {
    return taskDatasource.getTasks(
      status: status,
      offset: offset,
      limit: limit,
      sortBy: sortBy,
      isAsc: isAsc,
    );
  }
}
