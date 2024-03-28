import 'package:flutter_project/features/pin_code/data/datasource/pin_code_local_data_source.dart';
import 'package:flutter_project/features/pin_code/data/datasource/pin_code_remote_data_source.dart';
import 'package:flutter_project/features/pin_code/data/repositories/pin_code_repository_impl.dart';
import 'package:flutter_project/features/pin_code/domain/repositorys/pin_code_repository.dart';
import 'package:flutter_project/shared/data/remote/network_service.dart';
import 'package:flutter_project/shared/domain/providers/dio_network_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pinCodeDataSourceProvider =
    Provider.family<PinCodeLocalDataSource, NetworkService>(
  (_, networkService) => PinCodeLocalDataSource(),
);

final pinCodeRepositoryProvider = Provider<PinCodeRepository>(
  (ref) {
    final NetworkService networkService = ref.watch(networkServiceProvider);
    final PinCodeDataSource dataSource =
        ref.watch(pinCodeDataSourceProvider(networkService));
    return PinCodeRepositoryImpl(dataSource);
  },
);
