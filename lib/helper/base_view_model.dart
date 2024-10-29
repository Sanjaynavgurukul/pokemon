import 'package:flutter/material.dart';
import 'package:pokemon/db/repository.dart';

abstract class BaseViewModel extends ChangeNotifier {
  final Repository repository = Repository();

  void showToast({required String message, required BuildContext context});

  void displayToastMessage(
      {required String message, required BuildContext context}) {}
}
