import 'dart:convert';
import 'package:pokemon/db/api_response_model.dart';

class ResponseConverter {
  static ApiResponseModel getErrorResponse({required String message}) {
    return ApiResponseModel(hasError: true, data: {}, message: message);
  }

  static Uri convertToUri({required String url}) => Uri.parse(url);

  static ApiResponseModel getConvertedData(
      {required Map<String, dynamic> body, String? message}) {
    if (body.isEmpty) {
      return ApiResponseModel(
          message: 'Something went wrong!', hasError: true, data: {});
    }

    try {
      return ApiResponseModel(
          hasError: false, data: body, message: message ?? 'Success');
    } catch (e) {
      return ApiResponseModel(
          message: 'Incorrect data', hasError: true, data: {});
    }
  }

  static Map<String, dynamic> getJsonConvertedData({required String body}) {
    if (body.isEmpty) {
      return {'hasError': true, 'data': {}, 'message': 'Something  went wrong'};
    }

    try {
      Map<String, dynamic> convertToMap = jsonDecode(body);
      return {'message': 'Success', 'hasError': false, 'data': convertToMap};
    } catch (e) {
      return {
        'hasError': true,
        'data': {},
        'message': 'Failed to convert data'
      };
    }
  }
}
