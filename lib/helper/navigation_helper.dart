import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationHelper {
  Future<dynamic> navigatePush<T extends ChangeNotifier>({
    required BuildContext context,
    required T viewModel,
    required Widget screen,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ListenableProvider.value(
          value: viewModel,
          child: screen,
        ),
      ),
    );
  }

  void navigatePushReplacement<T extends ChangeNotifier>({
    required BuildContext context,
    required T viewModel,
    required Widget screen,
  }) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ListenableProvider.value(
          value: viewModel,
          child: screen,
        ),
      ),
    );
  }

  void navigatePushReplacementUntil<T extends ChangeNotifier>({
    required BuildContext context,
    required T viewModel,
    required Widget screen,
  }) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => ListenableProvider.value(
            value: viewModel,
            child: screen,
          ),
        ),
        (route) => route.isFirst);
  }

  void navigatePushAndRemoveUntil<T extends ChangeNotifier>({
    required BuildContext context,
    required T viewModel,
    required Widget screen,
  }) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => ListenableProvider.value(
            value: viewModel,
            child: screen,
          ),
        ),
        (route) => false);
  }

}
