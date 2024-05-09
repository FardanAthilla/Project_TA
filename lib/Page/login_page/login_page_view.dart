import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_ta/Page/login_page/model/controller.dart';
import 'package:project_ta/Page/login_page/model/token.dart';
import 'package:project_ta/Page/login_page/widget/textfield.dart';
import 'package:project_ta/Page/sidebar/navigation.dart';
import 'package:project_ta/color.dart';
import 'package:project_ta/Page/login_page/login_page_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginPageController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -width * 0.2,
              left: 0,
              right: 0,
              child: Container(
                height: width,
                child: Image.asset(
                  'Assets/login3.png',
                  fit: BoxFit.contain,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                height: height / 1.40,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "Assets/logo2.svg",
                      width: 800,
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
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    CustomTextField(
                      hintText: 'Username',
                      controllers: controller.emailTextEditingController,
                      icon: Icons.person,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      hintText: 'Password',
                      controllers: controller.passwordTextEditingController,
                      icon: Icons.lock,
                      isPassword: true,
                    ),
                    SizedBox(height: 40),
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 0),
                      child: ElevatedButton(
                        onPressed: () async {
                          final String email = Get.find<LoginPageController>()
                              .emailTextEditingController
                              .text;
                          final String password =
                              Get.find<LoginPageController>()
                                  .passwordTextEditingController
                                  .text;

                          try {
                            final String token =
                                await loginUser(email, password);
                            await saveToken(token);
                            print('Token: $token');
                            Get.off(Navigation());
                          } catch (e) {
                            print('Gagal login: $e');
                            Get.snackbar(
                              'Login Gagal',
                              e.toString(),
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Warna.main,
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, color: Warna.white),
                        ),
                      ),
                    )
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
