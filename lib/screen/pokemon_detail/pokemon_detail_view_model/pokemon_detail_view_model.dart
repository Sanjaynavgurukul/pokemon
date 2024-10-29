import 'package:flutter/material.dart';
import 'package:pokemon/helper/base_view_model.dart';

class PokemonDetailViewModel extends BaseViewModel {
  int selectedImageIndex = 0;
  bool isScrolled = false;

  @override
  void showToast({required String message, required BuildContext context}) {
    super.displayToastMessage(message: message, context: context);
  }

  void updateHomeScroll(bool status) {
    isScrolled = status;
    notifyListeners();
  }

  void updateSelectedImage({required int index}){
    selectedImageIndex = index;
    notifyListeners();
  }
}
