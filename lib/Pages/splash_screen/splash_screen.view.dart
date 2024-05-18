import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_ta/Pages/login_page/login_page_view.dart';
import 'package:project_ta/Pages/navigation/navbar_view.dart';
import 'package:project_ta/Pages/login_page/auth/token.dart';
import 'package:project_ta/color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedSplashScreen(
        backgroundColor: Warna.background,
        splash: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: SvgPicture.asset('Assets/logo2.svg'),
        ),
        nextScreen: getNextScreen(),
        splashTransition: SplashTransition.fadeTransition,
        duration: 2000,
        splashIconSize: 100,
      ),
    );
  }

  Widget getNextScreen() {
    return FutureBuilder<String?>(
      future: getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Warna.main,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Navbar();
          } else {
            return LoginPage();
          }
        }
      },
    );
  }
}
