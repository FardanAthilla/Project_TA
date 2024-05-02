import 'package:flutter/material.dart';
import 'package:project_ta/color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;

  const CustomTextField({
    Key? key,
    required this.hintText,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Username",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Warna.card
          ),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText, // Menggunakan hintText dari properti
                hintStyle: TextStyle(
                  fontSize: 12
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 17)
            ),
          ),
        ),
      ],
    );
  }
}
