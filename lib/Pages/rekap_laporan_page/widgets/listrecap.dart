import 'package:flutter/material.dart';

class ListRecap extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'Assets/iconlistmesin3.png',
            width: 52,
            height: 52,
          ),
        ],
      ),
    );
  }
}