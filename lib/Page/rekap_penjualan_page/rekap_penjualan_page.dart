import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project_ta/color.dart';

class SalesReportController extends GetxController {
  RxList salesData = [].obs;
  RxList filteredSalesData = [].obs;

  Future<void> fetchSalesReport() async {
    final response = await http
        .get(Uri.parse('https://secure-sawfly-certainly.ngrok-free.app/sales'));

    if (response.statusCode == 200) {
      salesData.value = json.decode(response.body)['Data'];
      filteredSalesData.value = salesData;
    } else {
      throw Exception('Failed to load sales report');
    }
  }

  void filterSalesData(String keyword) {
    if (keyword.isEmpty) {
      filteredSalesData.value = salesData;
    } else {
      filteredSalesData.value = salesData.where((data) {
        return data['item_name']
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            data['branch'].toLowerCase().contains(keyword.toLowerCase());
      }).toList();
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchSalesReport();
  }
}

class RekapLaporanPenjualan extends StatelessWidget {
  final SalesReportController controller = Get.put(SalesReportController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final FocusNode? searchFocusNode = FocusNode();
    initializeDateFormatting('id_ID', null);

    return Scaffold(
      backgroundColor: Warna.background,
      body: RefreshIndicator(
        onRefresh: () => controller.fetchSalesReport(),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                controller: searchController,
                focusNode: searchFocusNode,
                decoration: InputDecoration(
                  hintText: 'Cari',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onChanged: (value) {
                  controller.filterSalesData(value);
                },
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.salesData.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  Map<String, List<dynamic>> groupedSales = {};
                  List<String> dates = [];

                  for (var data in controller.filteredSalesData) {
                    var date = DateTime.parse(data['date']);
                    var formattedDate =
                        DateFormat('EEEE, d MMMM y', 'id_ID').format(date);
                    if (!groupedSales.containsKey(formattedDate)) {
                      groupedSales[formattedDate] = [];
                      dates.insert(0, formattedDate);
                    }
                    groupedSales[formattedDate]?.add(data);
                  }

                  return ListView.builder(
                    itemCount: groupedSales.length,
                    itemBuilder: (context, index) {
                      var currentDate = dates[index];
                      var currentData = groupedSales[currentDate];

                      return GestureDetector(
                        onTap: () {
                          searchFocusNode?.unfocus();
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
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: currentData!.length,
                              itemBuilder: (context, index) {
                                var data = currentData[index];
                                return Card(
                                  color: Warna.main,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: ListTile(
                                    title: Text(
                                      data['item_name'],
                                      style: TextStyle(color: Warna.white),
                                    ),
                                    subtitle: Text(
                                      data['branch'],
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
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
