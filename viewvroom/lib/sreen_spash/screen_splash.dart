
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:viewvroom/principale_page.dart';
// import 'splash';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
          ()=>Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder:
                                                          (context) => 
                                                        const PrincipalePage()
                                                         )
                                       )
         );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
   child: Image.asset('assets/splash_screen/splashscreen.png') ,
       ) ,
      // color: Colors.white,
     
      // FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }
}
