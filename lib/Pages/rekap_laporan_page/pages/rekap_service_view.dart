import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:project_ta/Pages/rekap_laporan_page/controllers/fetchservice.dart';
import 'package:project_ta/Pages/rekap_laporan_page/models/service_report_model.dart';
import 'package:project_ta/color.dart';
import 'package:project_ta/Pages/rekap_laporan_page/widgets/shimmer.dart'
    as rekapShimmer;

class RekapServicePage extends StatelessWidget {
  final FetchServiceController controller = Get.put(FetchServiceController());

  Future<void> _refreshData() async {
    controller.fetchServiceReports();
  }

  void _showDetailsPopup(BuildContext context, Datum report) {
    int sparePartsTotalPrice = report.serviceReportsItems.fold(0, (sum, item) {
      return sum + (item.price * item.quantity);
    });

    final formatter = NumberFormat('#,##0', 'id_ID');

    int totalPrice = report.totalPrice + sparePartsTotalPrice;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (report.image != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          report.image!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  Text(
                    'Detail Laporan Service',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                  SizedBox(height: 10),
                  _buildDetailRow('Pengguna', report.user.username),
                  _buildDetailRow(
                      'Mulai',
                      DateFormat('EEEE, d MMMM y', 'id_ID')
                          .format(report.date)),
                  _buildDetailRow(
                      'Selesai',
                      report.dateEnd != null
                          ? DateFormat('EEEE, d MMMM y', 'id_ID')
                              .format(report.dateEnd!)
                          : 'N/A'),
                  _buildDetailRow('Pelanggan', report.name),
                  _buildDetailRow('Nama Mesin', report.machineName),
                  _buildDetailRow('Keluhan', report.complaints),
                  _buildDetailRow('Harga Service',
                      'Rp. ${formatter.format(report.totalPrice)}'),
                  _buildDetailRow(
                      'Total Harga', 'Rp. ${formatter.format(totalPrice)}'),
                  SizedBox(height: 20),
                  Text(
                    'Tambahan Sparepart:',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  report.serviceReportsItems.isNotEmpty
                      ? Column(
                          children: report.serviceReportsItems.map((item) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                '${item.itemName} \nJumlah ${item.quantity}, Harga Rp. ${formatter.format(item.price * item.quantity)}',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                            );
                          }).toList(),
                        )
                      : Text(
                          'Tidak membutuhkan sparepart',
                          style: TextStyle(color: Colors.black54),
                        ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Warna.danger,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      icon: Icon(
                        Icons.logout,
                        color: Warna.white,
                      ),
                      label: Text(
                        "Kembali",
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
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black54,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 8,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  controller.fetchServiceReports();
                }
              },
              items: <String>['Hari ini', '7 Hari Yang Lalu', '30 Hari Yang Lalu','12 Bulan Yang Lalu']
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
          return rekapShimmer.buildShimmerService();
        } else {
          var service = controller.serviceData;
          if (service.isEmpty) {
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
                    padding:
                        const EdgeInsets.only(top: 15, left: 90, right: 90),
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
          } else {
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                itemCount: service.length,
                itemBuilder: (context, index) {
                  var report = service[index];
                  return GestureDetector(
                    onTap: () {
                      _showDetailsPopup(context, report);
                    },
                    child: Padding(
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
                                      .format(report.dateEnd!),
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
                                      'No Service: ',
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
