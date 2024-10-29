import 'package:pokemon/db/api_response_model.dart';
import 'package:pokemon/db/provider.dart';

class Repository {
  final Provider _provider = Provider();

  Future<ApiResponseModel> getPokemonMainList(
          {required int limit, required int page}) async =>
      await _provider.getPokemonMainList(limit: limit, page: page);

  Future<ApiResponseModel> getSearchResponse({required String query}) async =>
      _provider.getSearchResponse(query: query);
}
