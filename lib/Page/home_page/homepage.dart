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
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Warna.main,
              padding: const EdgeInsets.only(left: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text(
                  //   'Selamat datang, User!',
                  //   style: TextStyle(
                  //     fontSize: 23,
                  //     fontWeight: FontWeight.bold,
                  //     color: Warna.white,
                  //   ),
                  // ),
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
                  topLeft: Radius.circular(125.0),
                  topRight: Radius.zero,
                ),
              ),
              height: MediaQuery.of(context).size.height / 1.25,
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Selamat datang, Pak User!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Warna.main,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Semangat bekerja',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Warna.main,
                        ),
                      ),
                      SizedBox(height: 30),
                      Expanded(
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          childAspectRatio: 0.90,
                          mainAxisSpacing: 20.0,
                          crossAxisSpacing: 20.0,
                          physics: ClampingScrollPhysics(), //INI SIH biar gridnya bisa discroll tapi gak melebihi container luar
                          children: List.generate(
                            6,
                            (index) => GestureDetector(
                              onTap: onTapActions[index],
                              child: Card(
                                elevation: 3, 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Warna.card,
                                    borderRadius: BorderRadius.circular(
                                      15.0,
                                    ),
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
                                        SizedBox(height: 10),
                                        Text(
                                          "apa ya",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
