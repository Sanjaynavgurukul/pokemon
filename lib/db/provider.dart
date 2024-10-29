import 'package:pokemon/db/api_data_converter_helper.dart';
import 'package:pokemon/db/api_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/db/api_urls.dart';

class Provider {
  Future<ApiResponseModel> getPokemonMainList(
      {required int limit, required int page}) async {
    final response = await http.get(
      ResponseConverter.convertToUri(
          url: ApiUrl().pokemonListApi(page: page, limit: limit)),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    Map<String, dynamic> res =
        ResponseConverter.getJsonConvertedData(body: response.body);

    if (response.statusCode == 200) {
      return ResponseConverter.getConvertedData(body: res);
    } else {
      return ResponseConverter.getErrorResponse(message: res['message']);
    }
  }


  Future<ApiResponseModel> getSearchResponse(
      {required String query}) async {
    final response = await http.get(
      ResponseConverter.convertToUri(
          url: ApiUrl().pokemonSearchApi(query: query)),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    Map<String, dynamic> res =
    ResponseConverter.getJsonConvertedData(body: response.body);

    if (response.statusCode == 200) {
      return ResponseConverter.getConvertedData(body: res);
    } else {
      return ResponseConverter.getErrorResponse(message: res['message']);
    }
  }
}
