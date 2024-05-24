import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_ta/Pages/laporan_page/widget/widget.dart';
import 'package:project_ta/color.dart';

class LaporanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Warna.background,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'Assets/logo2.svg',
              width: 30,
              height: 30,
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: DateTextField(
          title: 'Tanggal,Bulan,Tahun',
          description: 'Pilih tanggal menggunakan kalendar.',
        ),
      ),
    );
  }
}
