import 'package:flutter_project/shared/widgets/app_activity/data/datasource/app_activity_local_datesource.dart';
import 'package:flutter_project/shared/widgets/app_activity/data/repositories/app_activity_repository_impl.dart';
import 'package:flutter_project/shared/widgets/app_activity/domain/repositories/app_activity_repository.dart';
import 'package:flutter_project/shared/data/local/storage_service.dart';
import 'package:flutter_project/shared/domain/providers/shared_preferences_storage_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appActivityDataSourceProvider =
    Provider.family<AppActivityDataSource, StorageService>(
        (ref, storageService) {
  return AppActivityLocalDatasource(storageService);
});

final appActivityRepositoryProvider = Provider<AppActivityRepository>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final datasource = ref.watch(appActivityDataSourceProvider(storageService));
  final repository = AppActivityRepositoryImpl(datasource);
  return repository;
});
