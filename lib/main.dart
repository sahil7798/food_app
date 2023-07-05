import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app_assignment/screens/home_screen.dart';
import 'package:food_app_assignment/screens/login_screen.dart';
import 'package:get/get.dart';
import 'constants.dart';
import 'controller/shared_pref.dart';

void main() {
  runApp(const MyApp());

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: primaryColor));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final sharedPref = SharedPrefrence();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sanvi Ready Mix',
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        //primarySwatch: Palette.kToDark,

        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,

          iconTheme: IconThemeData(color: Colors.white, size: 30
              // elevation: 2,
              ),
          titleTextStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w600),

          // textTheme: TextTheme(
          //   bodyText2: TextStyle(color: Colors.black54),
          // ),
        ),
      ),
      //home: LoginScreen(),
      home: FutureBuilder(
          future: sharedPref.tryAutoLogin(),
          builder: (contect, authResult) {
            if (authResult.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
              );
            } else {
              if (authResult.data == true) {
                return const HomeScreen();
              }
              return LoginScreen();
            }
          }),
    );
  }
}
