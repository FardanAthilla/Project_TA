import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_ta/Page/Sidebar/gap.dart';
import 'package:project_ta/Page/home_page/homepage.dart';
import 'package:project_ta/color.dart';

// Global key untuk mengakses ScaffoldState dari Navigation di mana pun dalam aplikasi
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

// Controller untuk mengelola state navigasi
class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  // Metode untuk memilih item dalam navigasi
  void selectItem(int index) {
    selectedIndex.value = index;
  }
}

class Navigation extends StatelessWidget {
  const Navigation({Key? key});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan instance dari NavigationController
    final navigationController = Get.put(NavigationController());

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Obx(
          () => buildAppBarTitle(navigationController.selectedIndex.value),
        ),
        backgroundColor: Warna.background,
        foregroundColor: Warna.main,
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

  // Metode untuk membangun judul AppBar berdasarkan index yang dipilih
  Widget buildAppBarTitle(int index) {
    switch (index) {
      case 1:
      case 2:
        return buildAppbarTitleWithSearch();
      default:
        return buildAppbarTitle();
    }
  }

  // Metode untuk membangun judul AppBar dengan ikon pencarian
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

  // Metode untuk membangun judul AppBar tanpa ikon pencarian
  Widget buildAppbarTitle() {
    return SvgPicture.asset(
      'Assets/logo2.svg',
      width: 30,
      height: 30,
    );
  }

  // Metode untuk membangun drawer sidebar
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

  // Metode untuk membangun header pada drawer
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

  // Metode untuk membangun item pada drawer
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
                Text(
                  title,
                  style: TextStyle(
                    color: Warna.main,
                    fontWeight: FontWeight.w700,
                  ),
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
                Text(
                  title,
                  style: TextStyle(
                    color: Warna.teks,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ].withSpaceBetween(width: 10),
            ),
          );
  }
}
