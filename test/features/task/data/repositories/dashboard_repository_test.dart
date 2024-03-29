import 'package:flutter_project/features/task/data/datasource/task_remote_data_source.dart';
import 'package:flutter_project/features/task/data/repositories/task_repository_impl.dart';
import 'package:flutter_project/features/task/domain/repository/task_repository.dart';
import 'package:flutter_project/shared/domain/models/either.dart';
import 'package:flutter_project/shared/domain/models/paginated_response.dart';
import 'package:flutter_project/shared/domain/models/task/task_status.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/dummy_data.dart';

void main() {
  late TaskDataSource dashboardDatasource;
  late TaskRepository dashboardRepository;
  final taskStatus = TaskStatus.TODO.value;

  setUpAll(() {
    dashboardDatasource = MockRemoteDatasource();
    dashboardRepository = TaskRepositoryImpl(dashboardDatasource);
  });

  group('Task Repository Test\n', () {
    test('Should return PaginatedResponse on success', () async {
      // arrange
      when(() => dashboardDatasource.getTasks(
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
            sortBy: any(named: 'sortBy'),
            isAsc: any(named: 'isAsc'),
            status: any(named: 'status'),
          )).thenAnswer(
        (_) async => Right(PaginatedResponse.fromJson({}, [])),
      );

      // assert
      final response = await dashboardRepository.getTasks(
        offset: 0,
        limit: ITEMS_PER_PAGE,
        sortBy: CREATE_AT,
        isAsc: true,
        status: taskStatus,
      );

      // act
      expect(response.isRight(), true);
    });
    test(
      'Should return AppException on failure',
      () async {
        // arrange
        when(() => dashboardDatasource.getTasks(
              offset: any(named: 'offset'),
              limit: any(named: 'limit'),
              sortBy: any(named: 'sortBy'),
              isAsc: any(named: 'isAsc'),
              status: any(named: 'status'),
            )).thenAnswer(
          (_) async => Left(ktestAppException),
        );

        // assert
        final response = await dashboardRepository.getTasks(
          offset: 0,
          limit: ITEMS_PER_PAGE,
          sortBy: CREATE_AT,
          isAsc: true,
          status: taskStatus,
        );

        // act
        expect(response.isLeft(), true);
      },
    );
  });
}

class MockRemoteDatasource extends Mock implements TaskRemoteDataSource {}
