import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_ta/Page/navigation/navbar.dart';
import 'package:project_ta/Page/navigation/routes/route.dart';
import 'package:project_ta/Page/splash_screen/splash_screen.view.dart';

void main() {
  runApp(const MainApp());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: SafeArea(
        child: Navbar(),
      ),
    );
  }
}
