import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SalesReportController extends GetxController {
  RxList salesData = [].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSalesReport();
  }

  Future<void> fetchSalesReport() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('https://rdo-app-o955y.ondigitalocean.app/sales'));
      if (response.statusCode == 200) {
        salesData.value = json.decode(response.body)['Data'];
      } else {
        throw Exception('Failed to load sales report');
      }
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false; // Set isLoading to false after fetching data
    }
  }
}

