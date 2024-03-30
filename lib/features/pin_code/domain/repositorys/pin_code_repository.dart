import 'package:flutter_project/shared/domain/models/either.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';

abstract class PinCodeRepository {
  Future<Either<AppException, bool>> checkPin({required String pinCode});
  Future<Either<AppException, bool>> setCorrectPinCode(
      {required String newPinCode});
}
