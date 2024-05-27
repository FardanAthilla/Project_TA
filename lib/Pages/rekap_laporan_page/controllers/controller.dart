import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project_ta/Pages/rekap_laporan_page/models/salesreportmodel.dart';

class SalesReportController extends GetxController {
  var salesReports = <SalesReport>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchSalesReports();
    super.onInit();
  }

  void fetchSalesReports() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('https://rdo-app-o955y.ondigitalocean.app/sales'));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        Iterable salesReportsJson = jsonResponse['Data'];
        salesReports.assignAll(salesReportsJson.map((model) => SalesReport.fromJson(model)).toList());
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } finally {
      isLoading(false);
    }
  }
}

