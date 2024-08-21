import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:project_ta/Pages/rekap_laporan_page/controllers/fetchsales.dart';
import 'package:project_ta/color.dart';
import 'package:project_ta/Pages/rekap_laporan_page/widgets/shimmer.dart'
    as rekapShimmer;
import 'package:dropdown_button2/dropdown_button2.dart';

class RekapPenjualanPage extends StatelessWidget {
  final SalesController controller = Get.put(SalesController());

  Future<void> _refreshData() async {
    controller.fetchSalesReports();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Warna.background,
        title: Obx(() {
          return DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              value: controller.selectedPeriod.value,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.selectedPeriod.value = newValue;
                  controller.fetchSalesReports();
                }
              },
              items: <String>['Hari ini', '7 hari lalu', 'Bulan lalu','Tahun lalu']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
          );
        }),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return rekapShimmer.buildShimmerPenjualan();
        } else {
          if (controller.salesData.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'Assets/report.json',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  const Text(
                    'Belum ada laporan',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15,left: 90,right: 90),
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
            );
          }
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView.builder(
              itemCount: controller.salesData.length,
              itemBuilder: (context, index) {
                var report = controller.salesData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
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
                                color: Warna.hitam,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Order ID: ${report.salesReportId}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        const Divider(),
                        const SizedBox(height: 8.0),
                        Column(
                          children: report.salesReportItems.isEmpty
                              ? []
                              : report.salesReportItems.map<Widget>((item) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100.0),
                                          child: Image.asset(
                                            item.category == "mesin"
                                                ? 'Assets/iconlistmesin3.png'
                                                : 'Assets/iconsparepart.png',
                                            width: 35,
                                            height: 35,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Text(item.itemName),
                                        ),
                                        Text(
                                          'x${item.quantity}',
                                          style: TextStyle(
                                            color: Warna.main,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
