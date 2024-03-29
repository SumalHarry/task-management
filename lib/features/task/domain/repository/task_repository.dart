import 'package:flutter_project/shared/domain/models/either.dart';
import 'package:flutter_project/shared/domain/models/paginated_response.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';

abstract class TaskRepository {
  Future<Either<AppException, PaginatedResponse>> getTasks({
    required int offset,
    required int limit,
    required String sortBy,
    required bool isAsc,
    required String status,
  });
}
