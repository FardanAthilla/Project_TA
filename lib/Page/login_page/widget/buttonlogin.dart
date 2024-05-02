import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Page/sidebar/sidebar.dart';
import 'package:project_ta/color.dart'; 

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 0),
      child: ElevatedButton(
        onPressed: () {
          Get.to(Navigation());
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ), backgroundColor: Warna.main, 
        ),
        child: Text(
          "Login",
          style: TextStyle(
            fontWeight: FontWeight.w800, 
            color: Warna.white
          ),
        ),
      ),
    );
  }
}
