import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon/screen/splash_screen/splash_screen.dart';
import 'package:pokemon/screen/splash_screen/view_model/splash_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SplashViewModel>(
            create: (_) => SplashViewModel()),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: MaterialApp(
          title: 'Pokemon',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              useMaterial3: false,
              appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.black),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    systemNavigationBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                    systemNavigationBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: Colors.white,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ))),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
