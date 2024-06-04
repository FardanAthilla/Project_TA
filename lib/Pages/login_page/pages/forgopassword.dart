import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/login_page/auth/controller.dart';

class forgotPassword extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lupa password'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password Baru'),
              ),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Konfirmasi Password'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (passwordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
                    Get.snackbar('Error', 'Password fields cannot be empty');
                  } else if (passwordController.text != confirmPasswordController.text) {
                    Get.snackbar('Error', 'Passwords do not match');
                  } else {
                    resetPassword(usernameController.text, passwordController.text);
                  }
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
