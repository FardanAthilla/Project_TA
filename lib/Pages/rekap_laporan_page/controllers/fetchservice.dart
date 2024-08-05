import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project_ta/Pages/rekap_laporan_page/models/service_report_model.dart';

class ServiceController extends GetxController {
  var serviceData = <Datum>[].obs;
  var isLoading = true.obs;
  var selectedPeriod = 'Hari ini'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchServiceReports();
  }

  void fetchServiceReports() async {
    try {
      isLoading(true);

      List<Datum> data;
      switch (selectedPeriod.value) {
        case 'Hari ini':
          data = await fetchServiceData(days: 1);
          break;
        case '7 hari lalu': 
          data = await fetchServiceData(days: 7);
          break;
        case 'Bulan lalu':
          data = await fetchServiceData(months: 1);
          break;
        default:
          data = await fetchServiceData();
      }

      serviceData.value = data;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<List<Datum>> fetchServiceData(
      {int days = 0, int months = 0, int years = 0}) async {
    final url = 'https://rdo-app-o955y.ondigitalocean.app/service/day/last?days=$days&months=$months&years=$years';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List;
        return jsonData.map((item) => Datum.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load service data');
      }
    } catch (e) {
      print(e);
      throw Exception('Error fetching service data');
    }
  }
}
