import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_ta/Page/login_page/widget/buttonlogin.dart';
import 'package:project_ta/Page/login_page/widget/textfield.dart';
import 'package:project_ta/color.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -width * 0.2, // Position at the top
              left: 0, // Align to the left
              right: 0, // Align to the right
             
child: Container(
  height: width,
  child: Image.asset(
    'Assets/login3.png',
    fit: BoxFit.contain, // Use BoxFit.contain
  ),
),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Warna.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 0, horizontal: 30),
                height: height / 1.40,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "Assets/logo2.svg",
                      width: 1000,
                    ),
                    SizedBox(height: 5),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Selamat datang!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Mohon login untuk melanjutkan',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    CustomTextField(
                      hintText: 'Masukkan Nama pengguna',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      hintText: 'Masukkan Password',
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ButtonLogin(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
