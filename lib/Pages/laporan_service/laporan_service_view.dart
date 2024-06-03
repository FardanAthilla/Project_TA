import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_ta/Pages/laporan_service/controllers/controllerservice.dart';
import 'package:project_ta/color.dart';

class ServiceReportPage extends StatelessWidget {
  final ServiceReportController controller = Get.put(ServiceReportController());

  Future<void> _refreshData() async {
    await controller.fetchServiceReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView.builder(
              itemCount: controller.serviceData.length,
              itemBuilder: (context, index) {
                var report = controller.serviceData[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('EEEE, d MMMM y', 'id_ID').format(report.date),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Order ID: ${report.serviceReportId}',
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
                        Text('Person: ${report.personName}'),
                        Text('Machine: ${report.machineName}'),
                        Text('Complaints: ${report.complaints}'),
                        Text('Status: ${report.status}'),
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
