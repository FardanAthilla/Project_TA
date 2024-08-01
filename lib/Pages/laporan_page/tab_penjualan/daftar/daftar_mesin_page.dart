import 'package:flutter/material.dart';
import 'package:project_ta/Pages/laporan_page/tab_penjualan/daftar/itemselection.dart';
import 'package:project_ta/Pages/laporan_page/tab_penjualan/daftar/pages/mesin_tab_view.dart';
import 'package:project_ta/Pages/laporan_page/tab_penjualan/daftar/pages/sparepart_tab_view.dart';
import 'package:project_ta/Pages/laporan_page/widget/custom_tabbar.dart';

class DaftarMesinPage extends StatelessWidget {
  final ItemSelectionController itemSelectionController;

  const DaftarMesinPage({super.key, required this.itemSelectionController});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pilih Barang'),
        ),
        body: CustomTabBar(
          tabs: const [
            Tab(text: 'ㅤMesinㅤ'),
            Tab(text: 'Sparepart'),
          ],
          tabViews: [
            MesinTabView(itemSelectionController: itemSelectionController),
            SparepartTabView(itemSelectionController: itemSelectionController),
          ],
        ),
      ),
    );
  }
}
