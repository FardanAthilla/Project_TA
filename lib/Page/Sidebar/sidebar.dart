import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_ta/Page/sidebar/gap.dart';
import 'package:project_ta/Page/home_page/homepage.dart';
import 'package:project_ta/color.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void selectItem(int index) {
    selectedIndex.value = index;
  }
}

class Navigation extends StatelessWidget {
  const Navigation({Key? key});

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Obx(
          () => buildAppBarTitle(navigationController.selectedIndex.value),
        ),
        backgroundColor: Warna.background,
        foregroundColor: Warna.main,
        centerTitle: false, // Geser teks ke kiri
        titleSpacing: 0, // ngatur spasi ke kiri
        leading: IconButton(
          icon: Icon(Icons.menu, color: Warna.teks),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: buildSidebar(),
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

  Widget buildAppBarTitle(int index) {
    switch (index) {
      case 1:
      case 2:
        return buildAppbarTitleWithSearch();
      default:
        return buildAppbarTitle();
    }
  }

  Widget buildAppbarTitleWithSearch() {
    return Row(
      children: [
        SvgPicture.asset(
          'Assets/logo2.svg',
          width: 30,
          height: 30,
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.search, color: Warna.teks),
          onPressed: () {
            // Tambahkan logika pencarian di sini
          },
        ),
      ],
    );
  }

  Widget buildAppbarTitle() {
    return SvgPicture.asset(
      'Assets/logo2.svg',
      width: 30,
      height: 30,
    );
  }

  Widget buildSidebar() {
    return Drawer(
      child: Material(
        color: Warna.background,
        child: GetBuilder<NavigationController>(
          builder: (controller) {
            return ListView(
              padding: EdgeInsets.fromLTRB(0, 10.0, 30.0, 10.0),
              children: <Widget>[
                buildDrawerHeader(),
                buildDrawerItem(0, 'Halaman Utama', Icons.dashboard),
                buildDrawerItem(1, 'Daftar Mesin', Icons.archive),
                buildDrawerItem(2, 'Daftar Sparepart', Icons.category),
                buildDrawerItem(3, 'Laporan Penjualan', Icons.delete),
                buildDrawerItem(4, 'Laporan Service', Icons.edit),
                buildDrawerItem(5, 'Rekap Penjualan', Icons.people),
                buildDrawerItem(6, 'Rekap Service', Icons.people),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildDrawerHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: kToolbarHeight,
      color: Warna.background,
      child: SvgPicture.asset(
        'Assets/logo2.svg',
        width: 30,
        height: 30,
      ),
    );
  }

  Widget buildDrawerItem(int index, String title, IconData icon) {
    final navigationController = Get.put(NavigationController());

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
                Icon(icon, color: Warna.main),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    color: Warna.main,
                    fontWeight: FontWeight.w700,
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(1000),
                  bottomRight: Radius.circular(1000),
                ),
              ),
              backgroundColor: Warna.background,
            ),
            child: Row(
              children: [
                Icon(icon, color: Warna.teks),
                SizedBox(width: 10),
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
}
