import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

extension CustomException on HttpResponse {

  String getException() {
    return DioException(
        error: response.statusMessage,
        response: response,
        requestOptions: response.requestOptions
    ).toString();
  }

}