import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/login_page/auth/controller.dart';
import 'package:project_ta/Pages/login_page/pages/otp_verify.dart';
import 'package:project_ta/Pages/login_page/widgets/textfield.dart';
import 'package:project_ta/color.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

// ignore: must_be_immutable
class NewPassword extends StatelessWidget {
  NewPassword({Key? key}) : super(key: key);

  final SendOtpController controller = Get.put(SendOtpController());
  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();
  bool isPasswordValid = false;

  @override
  Widget build(BuildContext context) {
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
              child: SizedBox(
                height: width,
                child: Image.asset(
                  'Assets/login3.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Warna.background),
                onPressed: () {
                  Get.back();
                },
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
                  borderRadius: const BorderRadius.only(
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
                    const SizedBox(height: 5),
                    const Center(
                      child: Column(
                        children: [
                          Text(
                            'Masukkan Password Baru',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomTextField(
                      hintText: 'Password Baru',
                      controllers: controller.passwordController,
                      icon: Icons.lock,
                      isPassword: true,
                    ),
                    const SizedBox(height: 40),
                    FlutterPwValidator(
                      key: validatorKey,
                      controller: controller.passwordController,
                      minLength: 8,
                      uppercaseCharCount: 1,
                      lowercaseCharCount: 1,
                      numericCharCount: 1,
                      specialCharCount: 0,
                      width: 300,
                      height: 125,
                      onSuccess: () {
                        isPasswordValid = true;
                      },
                      onFail: () {
                        isPasswordValid = false;
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (isPasswordValid) {
                            Get.to(() => OtpVerify());
                          } else {
                            Get.snackbar(
                              'Gagal',
                              'Gagal Mengubah Password',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Warna.danger,
                              colorText: Colors.white,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Warna.main,
                        ),
                        child: const Text(
                          'Ubah Password',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
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
