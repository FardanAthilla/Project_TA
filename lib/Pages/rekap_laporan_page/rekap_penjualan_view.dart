import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project_ta/Pages/daftar_page/widget/custom_tabbar.dart';
import 'package:project_ta/Pages/rekap_laporan_page/widgets/shimmer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:project_ta/color.dart';
import 'package:project_ta/Pages/rekap_laporan_page/controllers/controller.dart';

class RekapPenjualanPage extends StatelessWidget {
  final SalesReportController controller = Get.put(SalesReportController());

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Warna.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'Assets/logo2.svg',
              width: 30,
              height: 30,
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: controller.fetchSalesReport,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rekap Laporan Penjualan Mesin',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: CustomTabBar(
                  tabs: [
                    Tab(text: 'ㅤMesinㅤ'),
                    Tab(text: 'Service'),
                  ],
                  tabViews: [
                    rekapMesinPage(context, controller),
                    Placeholder(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rekapMesinPage(
      BuildContext context, SalesReportController controller) {
    return Obx(() {
      if (controller.salesData.isEmpty) {
        return ShimmerLoading(); // Display shimmer loading widget
      } else {
        Map<String, List<dynamic>> groupedSales = {};
        List<String> dates = [];

        for (var data in controller.salesData) {
          var date = DateTime.parse(data['date']);
          var formattedDate =
              DateFormat('EEEE, d MMMM y', 'id_ID').format(date);
          if (!groupedSales.containsKey(formattedDate)) {
            groupedSales[formattedDate] = [];
            dates.insert(0, formattedDate);
          }
          groupedSales[formattedDate]?.add(data);
        }

        return SingleChildScrollView(
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
                        return Card(
                          color: Warna.main,
                          margin:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: ListTile(
                            title: Text(
                              data['item_name'],
                              style: TextStyle(color: Warna.white),
                            ),
                            trailing: Text(
                              data['quantity'].toString(),
                              style: TextStyle(
                                color: Warna.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    });
  }
}
