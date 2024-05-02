import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageController extends GetxController {
  late final SharedPreferences prefs;
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  RxBool isObsecure = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  loadData() async {
    prefs = await SharedPreferences.getInstance();
  }

  togglePasswordVisibility() {
    // Toggle the value of isObsecure
    isObsecure.value = !isObsecure.value;
  }
}
