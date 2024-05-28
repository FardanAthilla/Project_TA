import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project_ta/Pages/rekap_laporan_page/models/salesreportmodel.dart';
import 'package:project_ta/Pages/rekap_laporan_page/widgets/shimmer.dart';
import 'package:project_ta/color.dart';
import 'package:project_ta/Pages/rekap_laporan_page/controllers/controller.dart';
import 'package:project_ta/Pages/daftar_page/widget/custom_tabbar.dart'; // Import CustomTabBar

class RekapPenjualanPage extends StatelessWidget {
  final SalesReportController controller = Get.put(SalesReportController());

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);

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
        if (controller.isLoading.value && controller.salesData.isEmpty) {
          return buildShimmer(); // Display shimmer loading widget
        } else {
          return CustomTabBar(
            tabs: [
              Tab(text: 'ㅤMesinㅤ'),
              Tab(text: 'Service'),
            ],
            tabViews: [
              rekapMesinPage(context, controller),
              Placeholder(), // Placeholder for the 'Service' tab
            ],
          );
        }
      }),
    );
  }

  Widget rekapMesinPage(BuildContext context, SalesReportController controller) {
    return Obx(() {
      if (controller.isLoading.value && controller.salesData.isEmpty) {
        return buildShimmer(); // Display shimmer loading widget
      } else if (controller.salesData.isEmpty) {
        return Center(child: Text('No data available'));
      } else {
        Map<String, List<SalesReportItem>> groupedSales = {};
        List<String> dates = [];

        for (var report in controller.salesData) {
          var formattedDate =
              DateFormat('EEEE, d MMMM y', 'id_ID').format(report.date);
          if (!groupedSales.containsKey(formattedDate)) {
            groupedSales[formattedDate] = [];
            dates.add(formattedDate); // Add to the end
          }
          groupedSales[formattedDate]?.addAll(report.salesReportItems);
        }

        // Sort dates in descending order
        dates.sort((a, b) {
          var dateA = DateFormat('EEEE, d MMMM y', 'id_ID').parse(a);
          var dateB = DateFormat('EEEE, d MMMM y', 'id_ID').parse(b);
          return dateB.compareTo(dateA);
        });

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: groupedSales.length,
              itemBuilder: (context, index) {
                var currentDate = dates[index];
                var currentData = groupedSales[currentDate];

                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          currentDate,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: currentData!.length,
                        itemBuilder: (context, index) {
                          var data = currentData[index];
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.asset(
                                        'Assets/iconlistmesin3.png',
                                        width: 52,
                                        height: 52,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.itemName,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Warna.hitam,
                                              fontWeight: FontWeight.w500, // Medium
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Jumlah barang: ${data.quantity}',
                                            style: TextStyle(
                                              color: Warna.card,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400, // Normal
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (currentData.length > 1 &&
                                  index != currentData.length - 1)
                                Container(
                                  width: 333, // Set the desired width here
                                  child: const Divider(), // Divider for list items
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }
    });
  }
}
