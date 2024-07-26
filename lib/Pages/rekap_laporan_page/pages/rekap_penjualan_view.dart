import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project_ta/Pages/rekap_laporan_page/widgets/shimmer.dart' as rekapShimmer;
import 'package:project_ta/color.dart';
import 'package:project_ta/Pages/rekap_laporan_page/controllers/controllersales.dart';

class RekapPenjualanPage extends StatelessWidget {
  final SalesReportController controller = Get.put(SalesReportController());

  Future<void> _refreshData() async {
    controller.fetchSalesReports();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return rekapShimmer.buildShimmer();
        } else {
          if (controller.salesData.isEmpty) {
            return Center(
                child: Text("Belum Ada Laporan."));
          }
          return ListView.builder(
            itemCount: controller.salesData.length,
            itemBuilder: (context, index) {
              var report = controller.salesData[index];
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
                              color: Warna.hitam,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Order ID: ${report.salesReportId}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Divider(),
                      SizedBox(height: 8.0),
                      Column(
                        children: report.salesReportItems.map<Widget>((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.asset(
                                    item.category == "mesin"
                                        ? 'Assets/iconlistmesin3.png'
                                        : 'Assets/iconsparepart.png',
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(width: 16),
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
          );
        }
      }),
    );
  }
}
