import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_ta/Pages/rekap_laporan_page/controllers/controllerservice.dart';
import 'package:project_ta/color.dart';
import 'package:project_ta/Pages/rekap_laporan_page/widgets/shimmer.dart'
    as rekapShimmer;

class RekapServicePage extends StatelessWidget {
  final ServiceReportController controller = Get.put(ServiceReportController());

  Future<void> _refreshData() async {
    await controller.fetchServiceReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return rekapShimmer.buildShimmerService();
        } else {
          var service = controller.serviceReports;
          if (service.isEmpty) {
            return Center(child: Text("Belum Ada Laporan."));
          } else {
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                itemCount: service.length,
                itemBuilder: (context, index) {
                  var report = service[index];
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
                                  fontSize: 14,
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
                                    fontSize: 14,
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
                                    borderRadius: BorderRadius.circular(100.0),
                                    child: Image.asset(
                                      'Assets/serviceicon4.png',
                                      width: 35,
                                      height: 35,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    'Order ID: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    '${report.serviceReportId}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
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
                                    'Customer: ',
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
                                    'Jenis mesin: ',
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }
      }),
    );
  }
}
