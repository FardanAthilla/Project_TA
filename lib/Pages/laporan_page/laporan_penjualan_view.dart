import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_mesin.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_sparepart.dart';
import 'package:project_ta/Pages/laporan_page/tab_penjualan/daftar/itemselection.dart';
import 'package:project_ta/Pages/laporan_page/tab_service/laporan_service_view.dart';
import 'package:project_ta/Pages/laporan_page/tab_penjualan/laporan_penjualan_page.dart';
import 'package:project_ta/Pages/laporan_page/widget/custom_tabbar.dart';
import 'package:project_ta/Pages/laporan_page/widget/widget.dart';
import 'package:project_ta/Pages/laporan_page/controllers/controllersales.dart';

class LaporanPage extends StatelessWidget {
  final ItemSelectionController itemSelectionController = Get.put(ItemSelectionController());
  final SalesReportController salesReportController = Get.put(SalesReportController());
  final StoreController storeController = Get.put(StoreController());
  final SparepartController sparepartController = Get.put(SparepartController());
  final DateController dateController = Get.put(DateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: CustomTabBar(
        tabs: const [
          Tab(text: 'Penjualan'),
          Tab(text: 'Service'),
        ],
        tabViews: [
          SalesTabView(
            itemSelectionController: itemSelectionController,
            storeController: storeController,
            sparepartController: sparepartController,
            dateController: dateController,
            salesReportController: salesReportController,
          ),
           ServiceReportPage(),
        ],
      ),
    );
  }
}
