import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_mesin.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_sparepart.dart';
import 'package:project_ta/Pages/daftar_page/daftar_barang_view.dart';
import 'package:project_ta/Pages/laporan_page/laporan_penjualan_view.dart';
import 'package:project_ta/Pages/navigation/navbar_controller.dart';
import 'package:project_ta/Pages/profile_page/profile_page_view.dart';
import 'package:project_ta/Pages/rekap_laporan_page/controllers/controllersales.dart';
import 'package:project_ta/Pages/rekap_laporan_page/rekap_penjualan/rekap_penjualan_view.dart';
import 'package:project_ta/color.dart';

class Navbar extends StatelessWidget {
  final NavbarController controller = Get.put(NavbarController());
  final StoreController storeController = Get.put(StoreController());
  final SparepartController sparepartController = Get.put(SparepartController());
  final SalesReportController salesController = Get.put(SalesReportController());


  Navbar({Key? key}) : super(key: key);

  List<Widget> _buildScreens() {
    return [
      DaftarMesin(),
      LaporanPage(),
      RekapPenjualanPage(),
      ProfilePage(),
    ];
  }

  List<BottomNavigationBarItem> _navbarItems() {
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'Assets/icon1.svg',
          width: 22,
          height: 22,
          color: Warna.teks,
        ),
        activeIcon: SvgPicture.asset(
          'Assets/icon1.svg',
          width: 22,
          height: 22,
          color: Warna.main,
        ),
        label: 'Stock',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'Assets/icon5.svg',
          width: 22,
          height: 22,
          color: Warna.teks,
        ),
        activeIcon: SvgPicture.asset(
          'Assets/icon5.svg',
          width: 22,
          height: 22,
          color: Warna.main,
        ),
        label: 'Lapor',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset('Assets/icon2.svg',
            width: 24, height: 24, color: Warna.teks),
        activeIcon: SvgPicture.asset(
          'Assets/icon2.svg',
          width: 24,
          height: 24,
          color: Warna.main,
        ),
        label: 'Rekap',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset('Assets/icon4.svg',
            width: 22, height: 22, color: Warna.teks),
        activeIcon: SvgPicture.asset(
          'Assets/icon4.svg',
          width: 22,
          height: 22,
          color: Warna.main,
        ),
        label: 'Profile',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() => IndexedStack(
              index: controller.selectedIndex.value,
              children: _buildScreens(),
            )),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, -1),
              ),
            ],
          ),
          child: Obx(() => BottomNavigationBar(
                items: _navbarItems(),
                currentIndex: controller.selectedIndex.value,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.black,
                onTap: (index) {
                  controller.onItemTapped(index);
                  if (index == 0) {
                    storeController.searchItems(storeController.searchController.text);
                    sparepartController.searchItems(sparepartController.searchController.text);
                  } if (index == 1) {
                      storeController.ItemSelect(storeController.searchControllerReport.text);
                      sparepartController.SparePartSelect(sparepartController.searchControllerReport.text);
                  } if (index == 2) {
                      salesController.fetchSalesReports();
                  }
                },
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
              )),
        ),
      ),
    );
  }
}
