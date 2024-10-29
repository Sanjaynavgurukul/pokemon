import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokemon/db/api_response_model.dart';
import 'package:pokemon/helper/base_view_model.dart';
import 'package:pokemon/model/pokemon_model.dart';

class LandingViewModel extends BaseViewModel {
  List<PokemonItemModel>? list;
  int pageCount = 1;
  bool fetchingMore = false;

  @override
  void showToast({required String message, required BuildContext context}) {
    super.displayToastMessage(message: message, context: context);
  }

  void getPokemonList({bool fetchMore = false}) async {
    if (fetchingMore) {
      return;
    }

    if (fetchMore) {
      pageCount++;
      fetchingMore = true;
      notifyListeners();
    }

    ApiResponseModel apiResponseModel =
        await repository.getPokemonMainList(limit: 10, page: pageCount);

    fetchingMore = false;
    notifyListeners();
    if (apiResponseModel.hasError) {
      return;
    }
    Map<String, dynamic> data = apiResponseModel.data['data'];
    PokemonModel pokemonModel = PokemonModel.fromJson(data, false);
    list ??= [];
    list!.addAll(pokemonModel.data!);
    notifyListeners();
  }
}
