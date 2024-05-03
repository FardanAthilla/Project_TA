import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Page/login_page/login_page_controller.dart';
import 'package:project_ta/color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;

  CustomTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginPageController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          
        ),
        SizedBox(height: 5),
        if (isPassword) // Kondisi jika isPassword adalah true
          Obx(() => Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Warna.card,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(
                        icon,
                        size: 18.0,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        obscureText: controller.isObsecure.value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hintText,
                          hintStyle: TextStyle(fontSize: 12),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => controller.togglePasswordVisibility(),
                      icon: Icon(
                        controller.isObsecure.value ? Icons.visibility_off : Icons.visibility,
                      ),
                      padding: EdgeInsets.zero,
                      iconSize: 18.0,
                    ),
                  ],
                ),
              ))
        else // Kondisi jika isPassword adalah false
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Warna.card,
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    icon,
                    size: 18.0,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
