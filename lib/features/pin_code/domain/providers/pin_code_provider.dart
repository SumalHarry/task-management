import 'package:flutter_project/features/pin_code/data/datasource/pin_code_local_data_source.dart';
import 'package:flutter_project/features/pin_code/data/repositories/pin_code_repository_impl.dart';
import 'package:flutter_project/features/pin_code/domain/repositorys/pin_code_repository.dart';
import 'package:flutter_project/shared/data/local/storage_service.dart';
import 'package:flutter_project/shared/domain/providers/shared_preferences_storage_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pinCodeDataSourceProvider =
    Provider.family<PinCodeLocalDataSource, StorageService>(
  (_, storageService) => PinCodeLocalDataSource(storageService),
);

final pinCodeRepositoryProvider = Provider<PinCodeRepository>(
  (ref) {
    final storageService = ref.watch(storageServiceProvider);
    final PinCodeDataSource dataSource =
        ref.watch(pinCodeDataSourceProvider(storageService));
    return PinCodeRepositoryImpl(dataSource);
  },
);
