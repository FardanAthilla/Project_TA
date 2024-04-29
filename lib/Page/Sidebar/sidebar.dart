import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_ta/Page/home_page/homepage.dart';
import 'package:project_ta/color.dart';

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

    return Obx(() => 
    Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: buildAppBarTitle(navigationController.selectedIndex.value),
          backgroundColor: navigationController.selectedIndex.value == 0 ? Warna.main : Warna.background,
          foregroundColor: Warna.white,
          centerTitle: false,
          titleSpacing: 0,
          leading: IconButton(  
            icon: Icon(Icons.menu, color: navigationController.selectedIndex.value == 0 ? Warna.white : Warna.teks,),
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
    )
    );
  }

  Widget buildAppBarTitle(int index) {
    switch (index) {
      case 0:
        return buildAppbarHomePage();
      case 1:
        return buildAppbarTitleSearchMesin();
      case 2:
        return buildAppbarTitleSearchSparepart();
      default:
        return buildAppbarTitle();
    }
  }


Widget buildAppbarHomePage() {
  return Row(
    children: [
      Spacer(),
      Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: Text(
          'Nama Kamu',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 10.0, left: 10),
        child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'path_to_your_image',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ],
  );
}



  Widget buildAppbarTitleSearchMesin() {
    return Row(
      children: [
        SvgPicture.asset(
          'Assets/logo2.svg',
          width: 30,
          height: 30,
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.search, color: Warna.teks),
          onPressed: () {
            // Tambahkan logika pencarian di sini
          },
        ),
      ],
    );
  }

  Widget buildAppbarTitleSearchSparepart() {
    return Row(
      children: [
        SvgPicture.asset(
          'Assets/logo2.svg',
          width: 30,
          height: 30,
        ),
        const Spacer(),
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

//Sidebar
  Widget buildSidebar() {
    return Drawer(
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
}
