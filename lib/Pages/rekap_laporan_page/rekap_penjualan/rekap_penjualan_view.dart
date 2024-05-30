import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project_ta/Pages/rekap_laporan_page/models/salesreportmodel.dart';
import 'package:project_ta/Pages/rekap_laporan_page/widgets/shimmer.dart';
import 'package:project_ta/color.dart';
import 'package:project_ta/Pages/rekap_laporan_page/controllers/controllersales.dart';
import 'package:project_ta/Pages/daftar_page/widget/custom_tabbar.dart';
import 'package:project_ta/Pages/rekap_laporan_page/detail_page/detail_page.dart';

class RekapPenjualanPage extends StatelessWidget {
  final SalesReportController controller = Get.put(SalesReportController());

  Future<void> _refreshData() async {
    await controller.fetchSalesReport();
  }

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
          return buildShimmer(); 
        } else {
          return RefreshIndicator(
            onRefresh: _refreshData,
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
          );
        }
      }),
    );
  }

  Widget rekapMesinPage(BuildContext context, SalesReportController controller) {
    return Obx(() {
      if (controller.isLoading.value && controller.salesData.isEmpty) {
        return Center(child: CircularProgressIndicator()); // Loading indicator
      } else if (controller.salesData.isEmpty) {
        return Center(child: Text('No data available'));
      } else {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.salesData.length,
                  itemBuilder: (context, index) {
                    var report = controller.salesData[index];
                    return GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: Card(  
                        margin: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${DateFormat('EEEE, d MMMM y', 'id_ID').format(report.date)}',
                                    style: TextStyle(
                                        color: Warna.hitam,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14),
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
                              SizedBox(
                                height: 3,
                              ),
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
                                        SizedBox(width: 16), // Space between image and text
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
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
