import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_sparepart.dart';
import 'package:project_ta/Pages/daftar_page/widget/shimmer.dart';
import 'package:project_ta/Pages/laporan_page/tab_penjualan/daftar/itemselection.dart';
import 'package:project_ta/Pages/laporan_page/tab_service/edit/edit_page.dart';
import 'package:project_ta/Pages/laporan_page/tab_service/form/form_page.dart';
import 'package:project_ta/Pages/laporan_page/widget/widget.dart';
import 'package:project_ta/Pages/laporan_page/controllers/controllerservice.dart';
import 'package:project_ta/Pages/profile_page/profile_controller.dart';
import 'package:project_ta/color.dart';

class ServiceReportPage extends StatelessWidget {
  final ServiceReportController _controller =
      Get.put(ServiceReportController());
  final ProfileController profileController = Get.put(ProfileController());
  final DateController dateController = Get.put(DateController());
  final ItemSelectionController itemSelectionController =
      Get.put(ItemSelectionController());
  final SparepartController sparepartController =
      Get.put(SparepartController());

  ServiceReportPage({super.key}) {
    final userId = profileController.userData?['user_id'] ?? 0;
    _controller.fetchServiceReportsByUserId(userId);
  }

  Future<void> _refreshData() async {
    final userId = profileController.userData?['user_id'] ?? 0;
    await _controller.fetchServiceReportsByUserId(userId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if (_controller.isUserLoading.value) {
            return buildShimmerService();
          } else {
            if (_controller.userSpecificReports.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => FormLaporanService(
                          dateController: dateController,
                        ));
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 0.5,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Kirim Laporan Service'),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Belum Ada Laporan."),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 90, right: 90),
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    _refreshData();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Warna.main,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    minimumSize: Size(double.infinity, 40),
                                  ),
                                  icon: Icon(
                                    Icons.replay_outlined,
                                    color: Warna.white,
                                  ),
                                  label: Text(
                                    "Segarkan",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Warna.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                itemCount: _controller.userSpecificReports.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => FormLaporanService(
                                    dateController: dateController,
                                  ));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 0.5,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Laporan Rekap Service'),
                                  Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => FormLaporanService(
                                    dateController: dateController,
                                  ));
                            },
                            child: Text(
                              'Service yang sedang berjalan:',
                              style: TextStyle(
                                color: Warna.b,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    var report = _controller.userSpecificReports[index - 1];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateFormat('EEEE, d MMMM y', 'id_ID')
                                      .format(report.date),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6.0, horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    color: Warna.main.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(color: Warna.main),
                                  ),
                                  child: Text(
                                    '${report.status.statusName}',
                                    style: TextStyle(
                                      color: Warna.hitam,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Divider(),
                            SizedBox(height: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      child: Image.asset(
                                        'Assets/serviceicon4.png',
                                        width: 35,
                                        height: 35,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      'No Service: ${report.serviceReportId}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Nama Pelanggan: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '${report.name}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Nama mesin: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '${report.machineName}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Keluhan: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          '${report.complaints}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      sparepartController
                                          .SparePartSelectService(
                                              sparepartController
                                                  .searchControllerService
                                                  .text);
                                      Get.to(() => EditPage(
                                            report: report,
                                            itemSelectionController:
                                                itemSelectionController,
                                          ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Warna.main,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Edit Data",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: Warna.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            );
          }
        }),
      ),
    );
  }
}
