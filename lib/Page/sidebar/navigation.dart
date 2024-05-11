import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_ta/Page/daftar_mesin_page.dart/daftar_mesin_page.dart';
import 'package:project_ta/Page/daftar_sparepart_page/daftar_sparepart_page.dart';
import 'package:project_ta/Page/home_page/homepage.dart';
import 'package:project_ta/Page/laporan_penjualan/laporan_penjualan_view.dart';
import 'package:project_ta/Page/rekap_penjualan_page/rekap_penjualan_page.dart';
import 'package:project_ta/Page/rekap_service_page/rekap_service_page.dart';
import 'package:project_ta/Page/sidebar/widget/appbar.dart';
import 'package:project_ta/Page/sidebar/widget/sidebar.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void selectItem(int index) {
    selectedIndex.value = index;
    update();
  }
}

//Appbar
class Navigation extends StatelessWidget {
  const Navigation({Key? key});

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());

    return SafeArea(
      child: Obx(
        () => Scaffold(
          key: scaffoldKey,
          appBar: MyAppBar(
            selectedIndex: navigationController.selectedIndex.value,
          ),
          drawer: buildSidebar(navigationController),
          body: Obx(
            () => IndexedStack(
              index: navigationController.selectedIndex.value,
              children: [
                HomePage(),
                DaftarMesinPage(),
                DaftarSparepartPage(),
                LaporanPenjualanPage(),
                Placeholder(),
                RekapLaporanPenjualan(),
                RekapLaporanService(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
