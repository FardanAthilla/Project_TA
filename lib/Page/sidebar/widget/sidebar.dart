import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_ta/Page/login_page/login_page_view.dart';
import 'package:project_ta/Page/login_page/auth/token.dart';
import 'package:project_ta/Page/sidebar/navigation.dart';
import 'package:project_ta/color.dart';

// Sidebar
Widget buildSidebar(NavigationController navigationController) {
  return SafeArea(
    child: Drawer(
      child: Material(
        color: Warna.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(0, 10.0, 30.0, 10.0),
                children: <Widget>[
                  buildDrawerHeader(),
                  const SizedBox(
                    height: 10,
                  ),
                  buildDrawerItem(0, 'Halaman Utama', 'Assets/dashboard.svg', navigationController),
                  buildDrawerItem(1, 'Daftar Mesin', 'Assets/sewing-machine.svg', navigationController),
                  buildDrawerItem(2, 'Daftar Sparepart', 'Assets/spare-parts.svg', navigationController),
                  Divider(color: Warna.white,indent: 16.0),
                  buildDrawerItem(3, 'Laporan Penjualan', 'Assets/sales.svg', navigationController),
                  buildDrawerItem(4, 'Laporan Service', 'Assets/information.svg', navigationController),
                  Divider(color: Warna.white,indent: 16.0),
                  buildDrawerItem(5, 'Rekap Penjualan', 'Assets/profit-report.svg', navigationController),
                  buildDrawerItem(6, 'Rekap Service', 'Assets/report.svg', navigationController),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  await removeToken();
                  navigationController.selectItem(0); // Navigate to index 0 (Home Page)
                  Get.back(); // Close the sidebar
                  Get.offAll(LoginPage()); // Navigate to the login page
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Warna.danger,
                ),
                icon: Icon(
                  Icons.logout,
                  color: Warna.white,
                ),
                label: Text(
                  "Logout",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildDrawerHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    height: kToolbarHeight,
    color: Warna.background,
    child: SvgPicture.asset(
      'Assets/logo2.svg',
      width: 30,
      height: 30,
    ),
  );
}

Widget buildDrawerItem(int index, String title, String iconPath, NavigationController navigationController) {
  return navigationController.selectedIndex.value == index
      ? Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Warna.mainblue,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
                color: Warna.main,
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(
                  color: Warna.main,
                  fontWeight: FontWeight.w900,
                ),
              )
            ],
          ),
        )
      : TextButton(
          onPressed: () {
            navigationController.selectItem(index);
            Get.back();
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(14),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            backgroundColor: Warna.background,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
                color: Warna.teks,
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(
                  color: Warna.teks,
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
          ),
        );
}
