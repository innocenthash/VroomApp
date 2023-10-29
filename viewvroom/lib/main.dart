import 'package:flutter/material.dart';
import 'package:viewvroom/options/options_couleurs.dart';
import 'package:viewvroom/principale_page.dart';
import 'package:viewvroom/sreen_spash/screen_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color nav = OptionsCouleurs.bgColor;
    Color bottom = OptionsCouleurs.primaryColor;
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: nav),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor:  Color.fromARGB(255, 255, 255, 255)) ,
      ),
      home: const PrincipalePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
