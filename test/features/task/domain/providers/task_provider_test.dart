import 'package:flutter_project/features/task/data/datasource/task_remote_data_source.dart';
import 'package:flutter_project/features/task/domain/providers/task_provider.dart';
import 'package:flutter_project/features/task/domain/repository/task_repository.dart';
import 'package:flutter_project/shared/domain/providers/dio_network_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final providerContainer = ProviderContainer();
  late dynamic networkService;
  late dynamic taskDataSource;
  late dynamic taskRespository;
  setUpAll(
    () {
      networkService = providerContainer.read(networkServiceProvider);
      taskDataSource =
          providerContainer.read(taskDatasourceProvider(networkService));
      taskRespository = providerContainer.read(taskRepositoryProvider);
    },
  );
  test('taskDatasourceProvider is a TaskDatasource', () {
    expect(
      taskDataSource,
      isA<TaskDataSource>(),
    );
  });
  test('taskRepositoryProvider is a TaskRepository', () {
    expect(
      taskRespository,
      isA<TaskRepository>(),
    );
  });
  test('taskRepositoryProvider returns a TaskRepository', () {
    expect(
      providerContainer.read(taskRepositoryProvider),
      isA<TaskRepository>(),
    );
  });
}
