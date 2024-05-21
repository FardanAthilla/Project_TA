import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/daftar_page/Pages/Mesin/build_mesin.dart';
import 'package:project_ta/Pages/daftar_page/Pages/Sparepart/build_sparepart.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_mesin.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_sparepart.dart';
import 'package:project_ta/Pages/daftar_page/widget/custom_tabbar.dart';
import 'package:project_ta/Pages/daftar_page/widget/shimmer.dart';
import 'package:project_ta/color.dart';

class DaftarMesin extends StatelessWidget {
  final StoreController storeController = Get.put(StoreController());
  final SparepartController sparepartController = Get.put(SparepartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Warna.background,
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
      body: Obx(() {
        if (storeController.isLoading.value || sparepartController.isLoading.value) {
          return buildShimmer();
        } else {
          return CustomTabBar(
            tabs: [
              Tab(text: 'ㅤMesinㅤ'),
              Tab(text: 'Sparepart'),
            ],
            tabViews: [
              buildMesinList(context, storeController),
              buildSparepartList(context, sparepartController),
            ],
          );
        }
      }),
    );
  }
}
