import 'package:flutter_project/features/task/data/datasource/task_remote_data_source.dart';
import 'package:flutter_project/features/task/data/repositories/task_repository_impl.dart';
import 'package:flutter_project/features/task/domain/repository/task_repository.dart';
import 'package:flutter_project/shared/data/remote/network_service.dart';
import 'package:flutter_project/shared/domain/providers/dio_network_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskDatasourceProvider = Provider.family<TaskDataSource, NetworkService>(
  (_, networkService) => TaskRemoteDataSource(networkService),
);

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(taskDatasourceProvider(networkService));
  final repository = TaskRepositoryImpl(datasource);
  return repository;
});
