import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_ta/Page/daftar_mesin_page.dart/daftar_mesin_page.dart';
import 'package:project_ta/Page/daftar_sparepart_page/daftar_sparepart_page.dart';
import 'package:project_ta/Page/home_page/homepage.dart';
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
    FocusNode tanggalFocusNode = FocusNode();
    FocusNode cabangFocusNode = FocusNode();
    FocusNode namaBarangFocusNode = FocusNode();
    FocusNode jumlahBarangFocusNode = FocusNode();
    final navigationController = Get.put(NavigationController());

    return SafeArea(
      child: Obx(
        () => Scaffold(
          key: scaffoldKey,
          appBar: MyAppBar(
            selectedIndex: navigationController.selectedIndex.value,
            tanggalFocusNode: tanggalFocusNode,
            cabangFocusNode: cabangFocusNode,
            namaBarangFocusNode: namaBarangFocusNode,
            jumlahBarangFocusNode: jumlahBarangFocusNode,
          ),
          drawer: buildSidebar(),
          body: Obx(
            () => IndexedStack(
              index: navigationController.selectedIndex.value,
              children: [
                HomePage(),
                DaftarMesinPage(),
                DaftarSparepartPage(),
                Placeholder(),
                Placeholder(),
                Placeholder(),
                Placeholder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
