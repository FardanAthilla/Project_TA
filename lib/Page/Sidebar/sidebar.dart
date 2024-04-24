import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_ta/Page/home_page/homepage.dart';
import 'package:project_ta/Page/Sidebar/gap.dart';
import 'package:project_ta/color.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void selectItem(int index) {
    selectedIndex.value = index;
  }
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.put(NavigationController());
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Obx(
          () => IndexedStack(
            index: navigationController.selectedIndex.value,
            children: [
              AppbarTitle("Halaman Utama"),
              AppbarTitle("Daftar Mesin"),
              AppbarTitle("Daftar Sparepart"),
              AppbarTitle("Laporan Penjualan"),
              AppbarTitle("Laporan Service"),
              AppbarTitle("Rekap Penjualan"),
              AppbarTitle("Rekap Service"),
            ],
          ),
        ),
        // Bakground appbar
        backgroundColor: Warna.background,
        // Teks di appbar
        foregroundColor: Warna.main,
        // Icon appbar
        leading: IconButton(
          icon: Icon(Icons.menu, color: Warna.teks),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: Sidebar(),
      body: Obx(
        () => IndexedStack(
          index: navigationController.selectedIndex.value,
          children: const [
            HomePage(),
            Placeholder(),
            Placeholder(),
            Placeholder(),
            Placeholder(),
            Placeholder(),
            Placeholder(),
          ],
        ),
      ),
    );
  }

  Widget Sidebar() {
    return Drawer(
      child: Material(
        // Background drawer
        color: Warna.background,
        child: GetBuilder<NavigationController>(
          builder: (controller) {
            return ListView(
              padding: EdgeInsets.fromLTRB(0, 10.0, 30.0, 10.0),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  height: kToolbarHeight,
                  // Header drawer
                  color: Warna.background,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'Assets/logo2.svg',
                        width: 30,
                        height: 30,
                      ),
                    ],
                  ),
                ),
                iconTextButton(0, 'Halaman Utama', Icons.dashboard),
                iconTextButton(1, 'Daftar Mesin', Icons.archive),
                iconTextButton(2, 'Daftar Sparepart', Icons.category),
                iconTextButton(3, 'Laporan Penjualan', Icons.delete),
                iconTextButton(4, 'Laporan Service', Icons.edit),
                iconTextButton(5, 'Rekap Penjualan', Icons.people),
                iconTextButton(6, 'Rekap Service', Icons.people),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget AppbarTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Warna.main,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget iconTextButton(int index, String title, IconData icon) {
    final NavigationController navigationController =
        Get.put(NavigationController());
    return navigationController.selectedIndex.value == index
        ? Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Warna.mainblue,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(1000),
                bottomRight: Radius.circular(1000),
              ),
            ),
            child: Row(
              children: [
                // Icon pas aktif
                Icon(icon, color: Warna.main),
                Text(
                  title,
                  // Teks pas aktif
                  style:
                      TextStyle(color: Warna.main, fontWeight: FontWeight.w700),
                )
              ].withSpaceBetween(width: 10),
            ),
          )
        : TextButton(
            onPressed: () {
              navigationController.selectItem(index);
              Get.back();
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1000)),
              // Pas ga aktif
              backgroundColor: Warna.background,
            ),
            child: Row(
              children: [
                Icon(icon, color: Warna.teks),
                Text(
                  title,
                  style: TextStyle(
                      // Teks pas ga aktif
                      color: Warna.teks,
                      fontWeight: FontWeight.normal),
                )
              ].withSpaceBetween(width: 10),
            ),
          );
  }
}
