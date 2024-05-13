import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {

  final TextEditingController usernameTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  RxBool isObsecure = true.obs;

  togglePasswordVisibility() {
    isObsecure.value = !isObsecure.value;
  }
}
