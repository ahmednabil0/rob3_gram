import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:rob3_garam/helper/const.dart';
import 'package:rob3_garam/screens/get_start_screen.dart';

class SplashScrean extends StatelessWidget {
  const SplashScrean({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: primaryColor,
      splashIconSize: 1000,
      splash: Image.asset(
        'assets/images/logo.png',
        height: 120,
      ),
      nextScreen: const GetStratedScreen(),
    );
  }
}
