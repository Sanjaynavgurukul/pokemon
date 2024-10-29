import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/helper/base_view_model.dart';
import 'package:pokemon/helper/navigation_helper.dart';
import 'package:pokemon/screen/landing/landing_screen.dart';
import 'package:pokemon/screen/landing/view_model/landing_view_model.dart';

class SplashViewModel extends BaseViewModel {
  @override
  void showToast({required String message, required BuildContext context}) {
    super.displayToastMessage(message: message, context: context);
  }

  void initSplashScreen({required BuildContext context}) async {
    Future.delayed(const Duration(seconds: 2), (() {
      NavigationHelper().navigatePushReplacement(
          context: context,
          screen: const LandingScreen(),
          viewModel: LandingViewModel());
    }));
  }
}
