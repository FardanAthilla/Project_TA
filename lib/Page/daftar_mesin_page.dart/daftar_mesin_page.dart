import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_ta/Page/sidebar/sidebar.dart';

class DaftarMesinPage extends StatelessWidget {
  const DaftarMesinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());
    return WillPopScope(
      onWillPop: () async {
        navigationController.selectedIndex.value = 0;
        return true;
      },
      child: Scaffold(),
    );
  }
}