import 'package:flutter_project/features/task/data/datasource/task_remote_data_source.dart';
import 'package:flutter_project/shared/data/remote/network_service.dart';
import 'package:flutter_project/shared/domain/models/response.dart';
import 'package:flutter_project/shared/domain/models/task/task_status.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/dashboard/dummy_tasklist.dart';
import '../../../../fixtures/dummy_data.dart';

void main() async {
  late NetworkService mockNetworkService;
  late TaskRemoteDataSource taskRemoteDataSource;
  final taskStatus = TaskStatus.TODO.value;

  setUpAll(() {
    mockNetworkService = MockNetworkService();
    taskRemoteDataSource = TaskRemoteDataSource(mockNetworkService);
  });
  group(
    'Task Remote Datasource Test\n',
    () {
      test(
          'should return PaginatedResponse on success and the data is in valid format',
          () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            statusMessage: '',
            data: ktestTaskResponse,
          ).toRight,
        );

        // act
        final resp = await taskRemoteDataSource.getTasks(
          offset: 0,
          limit: ITEMS_PER_PAGE,
          sortBy: CREATE_AT,
          isAsc: true,
          status: taskStatus,
        );

        // assert
        expect(resp.isRight(), true);
      });
      test(
          'should return PaginatedResponse on success and the data is not in valid format',
          () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            statusMessage: '',
            data: {},
          ).toRight,
        );

        // act
        final resp = await taskRemoteDataSource.getTasks(
          offset: 0,
          limit: ITEMS_PER_PAGE,
          sortBy: CREATE_AT,
          isAsc: true,
          status: taskStatus,
        );

        // assert
        expect(resp.isRight(), true);
      });
      test('should return AppException on success but the data is null',
          () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            statusMessage: '',
            data: null,
          ).toRight,
        );

        // act
        final resp = await taskRemoteDataSource.getTasks(
          offset: 0,
          limit: ITEMS_PER_PAGE,
          sortBy: CREATE_AT,
          isAsc: true,
          status: taskStatus,
        );

        // assert
        expect(resp.isLeft(), true);
      });
      test('should return AppException on failure', () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => ktestAppException.toLeft,
        );

        // act
        final resp = await taskRemoteDataSource.getTasks(
          offset: 0,
          limit: ITEMS_PER_PAGE,
          sortBy: CREATE_AT,
          isAsc: true,
          status: taskStatus,
        );

        // assert
        expect(resp.isLeft(), true);
      });
    },
  );
  group(
    'Task Remote Datasource Test(Search)\n',
    () {
      test(
          'Should return PaginatedResponse on success and the data is in valid format',
          () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            statusMessage: '',
            data: ktestTaskResponse,
          ).toRight,
        );

        // act
        final resp = await taskRemoteDataSource.getTasks(
          offset: 0,
          limit: ITEMS_PER_PAGE,
          sortBy: CREATE_AT,
          isAsc: true,
          status: taskStatus,
        );
        ;

        // assert
        expect(resp.isRight(), true);
      });
      test(
          'should return PaginatedResponse on success and the data is not in valid format',
          () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            statusMessage: '',
            data: {},
          ).toRight,
        );

        // act
        final resp = await taskRemoteDataSource.getTasks(
          offset: 0,
          limit: ITEMS_PER_PAGE,
          sortBy: CREATE_AT,
          isAsc: true,
          status: taskStatus,
        );

        // assert
        expect(resp.isRight(), true);
      });
      test('should return AppException on success but the data is null',
          () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            statusMessage: '',
            data: null,
          ).toRight,
        );

        // act
        final resp = await taskRemoteDataSource.getTasks(
          offset: 0,
          limit: ITEMS_PER_PAGE,
          sortBy: CREATE_AT,
          isAsc: true,
          status: taskStatus,
        );

        // assert
        expect(resp.isLeft(), true);
      });
      test('should return AppException on failure', () async {
        // arrange
        when(() => mockNetworkService.get(any(),
            queryParameters: any(named: 'queryParameters'))).thenAnswer(
          (_) async => ktestAppException.toLeft,
        );

        // act
        final resp = await taskRemoteDataSource.getTasks(
          offset: 0,
          limit: ITEMS_PER_PAGE,
          sortBy: CREATE_AT,
          isAsc: true,
          status: taskStatus,
        );

        // assert
        expect(resp.isLeft(), true);
      });
    },
  );
}

class MockNetworkService extends Mock implements NetworkService {}
