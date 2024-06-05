import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:project_ta/Pages/login_page/auth/controller.dart';
import 'package:project_ta/color.dart';

class OtpVerify extends StatelessWidget {
  OtpVerify({Key? key}) : super(key: key);

  final SendOtpController controller = Get.put(SendOtpController());

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
                            'Berikan OTP untuk verify',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Pinput(
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          border: Border.all(color: const Color(0xFFEDF1FF)),
                        ),
                      ),
                      controller: controller.otpController,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          controller.sendOtp(reset: true);
                        },
                        child: const Text(
                          "Kirim Ulang OTP",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Obx(
                      () => Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 0),
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () async {
                                  await controller.verifyOtpAndSetPassword(
                                      controller.usernameController.text,
                                      controller.passwordController.text,
                                      controller.otpController.text);
                                },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Warna.main,
                          ),
                          child: controller.isLoading.value
                              ? const Text(
                                  "Sedang memuat",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                )
                              : const Text(
                                  "Kirim",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                ),
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

final defaultPinTheme = PinTheme(
  width: 56,
  height: 60,
  textStyle: const TextStyle(
    fontSize: 22,
    color: Colors.black,
  ),
  decoration: BoxDecoration(
    color: const Color(0xFFEDF1FF),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.transparent),
  ),
);
