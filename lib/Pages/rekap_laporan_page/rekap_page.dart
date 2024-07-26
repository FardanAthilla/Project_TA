import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ta/Pages/rekap_laporan_page/pages/rekap_penjualan_view.dart';
import 'package:project_ta/Pages/rekap_laporan_page/pages/rekap_service_view.dart';
import 'package:project_ta/color.dart';
import 'package:project_ta/Pages/daftar_page/widget/custom_tabbar.dart';

class RekapLaporanPage extends StatelessWidget {
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
            ),
          ],
        ),
      ),
      body: CustomTabBar(
        tabs: [
          Tab(text: 'Penjualan'),
          Tab(text: 'Service'),
        ],
        tabViews: [
          RekapPenjualanPage(),
          RekapServicePage(),
        ],
      ),
    );
  }
}
