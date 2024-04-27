import 'package:flutter/material.dart';
import 'package:project_ta/color.dart';

class DaftarMesinPage extends StatelessWidget {
  const DaftarMesinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Warna.background,
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Center(
        child: Text('Ini adalah daftar mesin page woi'),
      ),
        ));
  }
}