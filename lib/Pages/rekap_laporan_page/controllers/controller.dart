
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:project_ta/Pages/laporan_page/widget/widget.dart';

class SalesReportController extends GetxController {
  RxList salesData = [].obs;
  RxList filteredSalesData = [].obs;
  var isLoading = false.obs;

  Future<void> fetchSalesReport() async {
    final response = await http
        .get(Uri.parse('https://rdo-app-o955y.ondigitalocean.app/sales'));

    if (response.statusCode == 200) {
      salesData.value = json.decode(response.body)['Data'];
      // filteredSalesData.value = salesData;
    } else {
      throw Exception('Failed to load sales report');
    }
  }

  void sendSalesReport(DateController date,selectedItems) async {
    isLoading(true);
    final response = await http
        .post(Uri.parse('https://rdo-app-o955y.ondigitalocean.app/sales'),
        body: jsonEncode({
          "date" : date.date.value,
          "item" : selectedItems
        }),
        );
    if (response.statusCode == 200) {
      selectedItems.clear();
      date.clear();
    isLoading(false);
    } else {
      print(response.body);
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchSalesReport();
  }
}
