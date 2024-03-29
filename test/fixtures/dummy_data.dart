import 'package:flutter_project/shared/domain/models/response.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';

final AppException ktestAppException =
    AppException(message: '', statusCode: 0, identifier: '');

final Response ktestResponse =
    Response(statusMessage: 'message', statusCode: 1, data: {});
