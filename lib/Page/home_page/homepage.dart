import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/color.dart';
import 'package:project_ta/Page/sidebar/sidebar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());

    List<String> teks = [
      'Daftar Mesin',
      'Daftar Sparepart',
      'Laporan Penjualan',
      'Laporan Service',
      'Rekap Penjualan',
      'Rekap Service',
    ];

    final double itemWidth = MediaQuery.of(context).size.width / 3;

    List<VoidCallback> onTapActions = [
      () {
        navigationController.selectedIndex.value = 1;
      },
      () {
        navigationController.selectedIndex.value = 2;
      },
      () {
        navigationController.selectedIndex.value = 3;
      },
      () {
        navigationController.selectedIndex.value = 4;
      },
      () {
        navigationController.selectedIndex.value = 5;
      },
      () {
        navigationController.selectedIndex.value = 6;
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selamat datang, User!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Warna.main,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 0.90,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  children: List.generate(
                    6,
                    (index) => GestureDetector(
                      onTap: onTapActions[index],
                      child: Card(
                        elevation: 3, // Bayangan card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Warna.card,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'Assets/$index.png',
                                  width: itemWidth * 0.6,
                                  height: itemWidth * 0.6,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  teks[index],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Warna.teks,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
