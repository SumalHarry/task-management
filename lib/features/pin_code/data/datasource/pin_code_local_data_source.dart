import 'package:flutter_project/features/pin_code/data/datasource/pin_code_remote_data_source.dart';
import 'package:flutter_project/shared/domain/models/either.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';

class PinCodeLocalDataSource implements PinCodeDataSource {
  PinCodeLocalDataSource();
  final String _correctPin = '111111';

  @override
  Future<Either<AppException, bool>> checkPin({required String pinCode}) async {
    try {
      await Future.delayed(const Duration(milliseconds: 100));
      bool isPinCorrect = (pinCode == _correctPin);
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
}
