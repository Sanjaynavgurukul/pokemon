import 'dart:developer';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/db/api_response_model.dart';
import 'package:pokemon/helper/base_view_model.dart';
import 'package:pokemon/model/pokemon_model.dart';

class SearchViewModel extends BaseViewModel {
  bool searchOpen = true;
  bool showLoader = false;
  bool isScrolled = false;

  PokemonModel? pokemonModel;

  @override
  void showToast({required String message, required BuildContext context}) {
    super.displayToastMessage(message: message, context: context);
  }

  void updateSearchOpenStatus({required bool open}) {
    searchOpen = open;
    notifyListeners();
  }

  void getSearchResponse({required String query}) async {
    showLoader = true;
    notifyListeners();
    ApiResponseModel apiResponseModel =
        await repository.getSearchResponse(query: query);
    showLoader = false;
    notifyListeners();
    if (apiResponseModel.hasError) {
      pokemonModel = PokemonModel(hasError: true);
      notifyListeners();
      return;
    }

    Map<String, dynamic> data = apiResponseModel.data['data'];
    pokemonModel = PokemonModel.fromJson(data, false);
    notifyListeners();
  }
}
