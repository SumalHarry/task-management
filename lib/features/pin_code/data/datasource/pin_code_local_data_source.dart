import 'package:flutter_project/shared/data/local/storage_service.dart';
import 'package:flutter_project/shared/domain/models/either.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';
import 'package:flutter_project/shared/globals.dart';

abstract class PinCodeDataSource {
  String get storageKeyPinCode;

  Future<Either<AppException, bool>> checkPin({required String pinCode});
  Future<Either<AppException, bool>> setCorrectPinCode(
      {required String newPinCode});
  Future<String> getCorrectPinCode();
}

class PinCodeLocalDataSource implements PinCodeDataSource {
  PinCodeLocalDataSource(this.storageService);

  final StorageService storageService;
  final String _defaultCorrectPin = DEFAULT_CORRECT_PIN;

  @override
  String get storageKeyPinCode => PIN_CODE_LOCAL_STORAGE_KEY;

  @override
  Future<Either<AppException, bool>> checkPin({required String pinCode}) async {
    try {
      await Future.delayed(const Duration(milliseconds: 100));
      String correctPin = await getCorrectPinCode();
      bool isPinCorrect = (pinCode == correctPin);
      return Right(isPinCorrect);
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\\PinCodeLocalDataSource.checkPin',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, bool>> setCorrectPinCode(
      {required String newPinCode}) async {
    try {
      bool result = await storageService.set(storageKeyPinCode, newPinCode);
      return Right(result);
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\\PinCodeLocalDataSource.checkPin',
        ),
      );
    }
  }

  @override
  Future<String> getCorrectPinCode() async {
    final data = await storageService.get(storageKeyPinCode);
    return data?.toString() ?? _defaultCorrectPin;
  }
}
