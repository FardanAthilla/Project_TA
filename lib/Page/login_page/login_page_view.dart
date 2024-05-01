import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_ta/Page/sidebar/sidebar.dart';
import 'package:project_ta/color.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'Assets/login3.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Warna.background, 
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              height: height / 1.40,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded( 
                    child: Align(
                      alignment: Alignment.topCenter, //ini nguawur 
                      child: SvgPicture.asset(
                        "Assets/logo2.svg",
                        width: 800,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(Navigation());
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
