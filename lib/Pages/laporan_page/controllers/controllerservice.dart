import 'package:get/get.dart';
import 'package:project_ta/Pages/rekap_laporan_page/models/service_report_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ServiceReportController extends GetxController {
  var serviceReports = <Datum>[].obs;
  var userSpecificReports = <Datum>[].obs;
  var isLoading = false.obs;
  var isUserLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchServiceReports();
  }

  Future<void> fetchServiceReports() async {
    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse('https://rdo-app-o955y.ondigitalocean.app/service/status/2'),
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['Data'];
        serviceReports.value =
            jsonResponse.map((report) => Datum.fromJson(report)).toList();
      } else {
        throw Exception('Failed to load service reports');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchServiceReportsByUserId(int userId) async {
    isUserLoading.value = true;

    try {
      final Uri apiUrl = Uri.parse(
          'https://rdo-app-o955y.ondigitalocean.app/service/$userId');
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['Data'];
        userSpecificReports.value =
            jsonResponse.map((report) => Datum.fromJson(report)).toList();
      } else {
        throw Exception('Failed to load service reports for user $userId');
      }
    } catch (e) {
      print(e);
    } finally {
      isUserLoading.value = false;
    }
  }
}
