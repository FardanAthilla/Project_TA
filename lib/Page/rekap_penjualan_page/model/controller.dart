import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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