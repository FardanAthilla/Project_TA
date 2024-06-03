
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServiceReportController extends GetxController {
  RxList salesData = [].obs;
  RxList filteredSalesData = [].obs;

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

  @override
  void onInit() {
    super.onInit();
    fetchSalesReport();
  }

  fetchServiceReports() {}
}
