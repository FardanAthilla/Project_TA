import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_ta/Page/sidebar/navigation.dart';
import 'package:project_ta/color.dart';

//Sidebar
  Widget buildSidebar() {
    return SafeArea(
      child: Drawer(
        child: Material(
          color: Warna.background,
          child: GetBuilder<NavigationController>(
            builder: (controller) {
              return ListView(
                padding: const EdgeInsets.fromLTRB(0, 10.0, 30.0, 10.0),
                children: <Widget>[
                  buildDrawerHeader(),
                  const SizedBox(
                    height: 10,
                  ),
                  buildDrawerItem(0, 'Halaman Utama', 'Assets/dashboard.svg'),
                  buildDrawerItem(1, 'Daftar Mesin', 'Assets/sewing-machine.svg'),
                  buildDrawerItem(
                      2, 'Daftar Sparepart', 'Assets/spare-parts.svg'),
                  buildDrawerItem(3, 'Laporan Penjualan', 'Assets/sales.svg'),
                  buildDrawerItem(4, 'Laporan Service', 'Assets/information.svg'),
                  buildDrawerItem(
                      5, 'Rekap Penjualan', 'Assets/profit-report.svg'),
                  buildDrawerItem(6, 'Rekap Service', 'Assets/report.svg'),
                ],
              );
            },
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

  Widget buildDrawerItem(int index, String title, String iconPath) {
    final navigationController = Get.put(NavigationController());

    return navigationController.selectedIndex.value == index
        ? Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Warna.mainblue,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(1000),
                bottomRight: Radius.circular(1000),
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
                  topRight: Radius.circular(1000),
                  bottomRight: Radius.circular(1000),
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