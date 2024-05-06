import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_ta/Page/sidebar/navigation.dart';
import 'package:project_ta/color.dart';

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

    bool _isBackPressedOnce = false;
    return WillPopScope(
        onWillPop: () async {
          if (navigationController.selectedIndex.value == 0) {
            if (_isBackPressedOnce) {
              return true;
            } else {
              _isBackPressedOnce = true;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Press back again to exit'),
                  duration: Duration(seconds: 2),
                ),
              );
              Future.delayed(Duration(seconds: 2), () {
                _isBackPressedOnce = false;
              });
              return false;
            }
          } else {
            navigationController.selectedIndex.value = 0;
            return false;
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Warna.main,
                padding: const EdgeInsets.only(left: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halaman Utama',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Warna.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Warna.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                height: MediaQuery.of(context).size.height / 1.25,
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 0.90,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    children: List.generate(
                      6,
                      (index) => GestureDetector(
                        onTap: onTapActions[index],
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
              ),
            ),
          ],
        ));
  }
}
