import 'package:flutter/material.dart';
import 'package:project_ta/color.dart';

class LaporanPenjualanPage extends StatelessWidget {
  const LaporanPenjualanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Warna.background,
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Center(
        child: Text('Ini adalah laporan penjualan page ya'),
      ),
        ));
  }
}