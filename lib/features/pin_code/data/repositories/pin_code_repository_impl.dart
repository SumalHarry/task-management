import 'package:flutter_project/features/pin_code/data/datasource/pin_code_local_data_source.dart';
import 'package:flutter_project/features/pin_code/domain/repositorys/pin_code_repository.dart';
import 'package:flutter_project/shared/domain/models/either.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';

class PinCodeRepositoryImpl extends PinCodeRepository {
  final PinCodeDataSource dataSource;

  PinCodeRepositoryImpl(this.dataSource);

  @override
  Future<Either<AppException, bool>> checkPin({required String pinCode}) {
    return dataSource.checkPin(pinCode: pinCode);
  }

  @override
  Future<Either<AppException, bool>> setCorrectPinCode(
      {required String newPinCode}) {
    return dataSource.setCorrectPinCode(newPinCode: newPinCode);
  }
}
