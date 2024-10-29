import 'package:flutter/material.dart';
import 'package:pokemon/screen/splash_screen/view_model/splash_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashViewModel viewModel;


  @override
  void didChangeDependencies() {
    viewModel = context.watch<SplashViewModel>();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      viewModel.initSplashScreen(context: context);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 130,
              height: 130,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Pokemon',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 30,
              child: LinearProgressIndicator(
                minHeight: 2,
                color: Colors.grey.shade300,
                backgroundColor: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
