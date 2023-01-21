import 'package:dio/dio.dart';

import '../../../constatnts/costants.dart';
import '../../../constatnts/strings.dart';

class ServiceErrors {
  String getRegularServicesError(RegularServicesErrors registerationErrorCode) {
    switch (registerationErrorCode) {
      case RegularServicesErrors.requestError:
        return Strings().requestError;
      case RegularServicesErrors.noConnection:
        return Strings().noConnection;
      case RegularServicesErrors.unKnownError:
        return Strings().unKnownError;
      case RegularServicesErrors.connectTimeOut:
        return Strings().connectTimeOut;
      case RegularServicesErrors.receiveTimeout:
        return Strings().receiveTimeout;
      case RegularServicesErrors.unAuthorized:
        return Strings().unAuthorized;
      case RegularServicesErrors.notFound:
        return Strings().unKnownError;
    }
  }

  Future<Response<dynamic>> identifiyError(DioError error) {
    if (error.type == DioErrorType.connectTimeout) {
      return Future.error(RegularServicesErrors.connectTimeOut);
    } else if (error.type == DioErrorType.receiveTimeout) {
      return Future.error(RegularServicesErrors.receiveTimeout);
    } else if (error.response == null) {
      print("dio error test null response");
      return Future.error(RegularServicesErrors.unKnownError);
    } else if (error.response!.statusCode == 401) {
      return Future.error(RegularServicesErrors.unAuthorized);
    } else if (error.response!.statusCode == 404) {
      return Future.error(RegularServicesErrors.notFound);
    } else {
      print("dio error test else");
      return Future.error(RegularServicesErrors.unKnownError);
    }
  }
}
