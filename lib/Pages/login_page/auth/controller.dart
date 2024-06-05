import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_ta/Pages/login_page/pages/login_page_view.dart';
import 'package:project_ta/Pages/login_page/pages/new_password.dart';
import 'package:project_ta/color.dart';

Future<String> loginUser(String username, String password) async {
  final Uri apiUrl =
      Uri.parse('https://rdo-app-o955y.ondigitalocean.app/login');
  final Map<String, String> requestBody = {
    'username': username,
    'password': password
  };

  try {
    final response = await http.post(
      apiUrl,
      body: jsonEncode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String token = responseData['Token'];
      return token;
    } else {
      throw Exception('Failed to login');
    }
  } catch (e) {
    throw Exception('Failed to connect to the server');
  }
}

class SendOtpController extends GetxController {
  var isLoading = false.obs;
  final TextEditingController usernameController = TextEditingController();

  void sendOtp({bool reset = false}) async {
    isLoading.value = true;
    final url = 'https://rdo-app-o955y.ondigitalocean.app/otp';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': usernameController.text,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar(
        'Berhasil Mengirim',
        'Otp Berhasil Dikirim',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Warna.main,
        colorText: Colors.white,
      );
      if (reset) {
      } else {
        Get.to(NewPassword());
      }
    } else {
      Get.snackbar(
        'Gagal',
        'Username Tidak Ditemukan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Warna.main,
        colorText: Colors.white,
      );
    }
    isLoading.value = false;
  }

  final otpController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> verifyOtpAndSetPassword(
      String username, String password, String otp) async {
    isLoading.value = true;
    try {
      var response = await http.post(
        Uri.parse('https://rdo-app-o955y.ondigitalocean.app/forgot/password'),
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
          'otp': otp,
        }),
      );
      if (response.statusCode == 200) {
        Get.snackbar(
          'Berhasil Mengubah',
          'Password Berhasil Diubah',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Warna.main,
          colorText: Colors.white,
        );
        Get.offAll(LoginPage());
      } else {
        Get.snackbar(
          'Gagal',
          'Gagal Mengirim Password',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Warna.danger,
          colorText: Colors.white,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
}
