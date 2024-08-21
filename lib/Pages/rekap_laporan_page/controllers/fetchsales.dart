import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_ta/Pages/rekap_laporan_page/models/salesreportmodel.dart';
import 'dart:convert';

class SalesController extends GetxController {
  var salesData = <SalesReport>[].obs;
  var isLoading = true.obs;
  var selectedPeriod = 'Hari ini'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSalesReports();
  }

  void fetchSalesReports() async {
    try {
      isLoading(true);

      List<SalesReport> data;
      switch (selectedPeriod.value) {
        case 'Hari ini':
          data = await fetchSalesData(days: 1);
          break;
        case '7 hari lalu':
          data = await fetchSalesData(days: 7);
          break;
        case 'Bulan lalu':
          data = await fetchSalesData(months: 1);
          break;
        case 'Tahun lalu':
          data = await fetchSalesData(years: 1);
          break;
        default:
          data = await fetchSalesData();
      }

      salesData.value = data;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<List<SalesReport>> fetchSalesData(
      {int days = 0, int months = 0, int years = 0}) async {
    final url =
        'https://rdo-app-o955y.ondigitalocean.app/sales/day/last?days=$days&months=$months&years=$years';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List;
        return jsonData.map((item) => SalesReport.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load sales data');
      }
    } catch (e) {
      print(e);
      throw Exception('Error fetching sales data');
    }
  }
}
