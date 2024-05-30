import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_ta/Pages/laporan_service/models/service_report_model.dart';
import 'dart:convert';
import 'package:project_ta/color.dart';

class ServiceReportController extends GetxController {
  RxList<ServiceReportModel> serviceData = <ServiceReportModel>[].obs;
  var isLoading = false.obs;

  Future<void> fetchServiceReports() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://rdo-app-o955y.ondigitalocean.app/service'));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        Iterable serviceReportsJson = jsonResponse['Data'];
        serviceData.assignAll(serviceReportsJson
            .map((model) => ServiceReportModel.fromJson(model))
            .toList());
      } else {
        throw Exception('Failed to load service reports');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        'Failed to fetch service reports',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Warna.danger,
        colorText: Warna.teksactive,
      );
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    fetchServiceReports();
    super.onInit();
  }
}
