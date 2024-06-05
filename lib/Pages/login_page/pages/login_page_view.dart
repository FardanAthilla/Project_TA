import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_mesin.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_sparepart.dart';
import 'package:project_ta/Pages/login_page/auth/controller.dart';
import 'package:project_ta/Pages/login_page/auth/token.dart';
import 'package:project_ta/Pages/login_page/pages/send_otp.dart';
import 'package:project_ta/Pages/login_page/widgets/textfield.dart';
import 'package:project_ta/color.dart';
import 'package:project_ta/Pages/login_page/login_page_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginPageController());
    final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
    final StoreController storeController = Get.put(StoreController());
    final SparepartController sparepartController =
        Get.put(SparepartController());
    bool isSnackbarActive = false;

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
                    const SizedBox(height: 40),
                    CustomTextField(
                      hintText: 'Username',
                      controllers: controller.usernameTextEditingController,
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      hintText: 'Password',
                      controllers: controller.passwordTextEditingController,
                      icon: Icons.lock,
                      isPassword: true,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(SendOtp());
                          },
                          child: Text(
                            'Lupa Password?',
                            style: TextStyle(fontSize: 12, color: Warna.main),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    ValueListenableBuilder<bool>(
                      valueListenable: isLoading,
                      builder: (context, loading, child) {
                        return Container(
                          width: double.infinity,
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          child: ElevatedButton(
                            onPressed: loading
                                ? null
                                : () async {
                                    isLoading.value = true;
                                    final usernameController = controller
                                        .usernameTextEditingController;
                                    final passwordController = controller
                                        .passwordTextEditingController;
                                    final String username =
                                        usernameController.text;
                                    final String password =
                                        passwordController.text;

                                    try {
                                      final String token =
                                          await loginUser(username, password);
                                      await saveToken(token);
                                      print('Token: $token');
                                      usernameController.clear();
                                      passwordController.clear();
                                      if (!isSnackbarActive) {
                                        isSnackbarActive = true;
                                        Get.snackbar(
                                          'Login Berhasil',
                                          '$username berhasil login.',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Warna.main,
                                          colorText: Colors.white,
                                          margin: EdgeInsets.only(
                                              bottom: 50.0), 
                                        );
                                      }
                                      storeController.searchItems(
                                          storeController
                                              .searchController.text);
                                      sparepartController.searchItems(
                                          sparepartController
                                              .searchController.text);
                                      Get.offNamed("/navbar");
                                    } catch (e) {
                                      print('Gagal login: $e');
                                      if (!isSnackbarActive) {
                                        isSnackbarActive = true;
                                        Get.snackbar(
                                          'Login Gagal',
                                          'Terjadi kesalahan saat melakukan login. Mohon isi data yang sesuai.',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Warna.danger,
                                          colorText: Colors.white,
                                          margin: EdgeInsets.only(
                                              bottom: 10.0), 
                                        );
                                      }
                                    } finally {
                                      isLoading.value = false;
                                      Future.delayed(Duration(seconds: 2), () {
                                        isSnackbarActive = false;
                                      });
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Warna.main,
                            ),
                            child: loading
                                ? Text(
                                    "Sedang memuat",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  )
                                : Text(
                                    "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Warna.white),
                                  ),
                          ),
                        );
                      },
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
