import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_ta/Pages/laporan_page/widget/widget.dart';
import 'dart:convert';
import 'package:project_ta/Pages/rekap_laporan_page/models/salesreportmodel.dart';
import 'package:project_ta/color.dart';

class SalesReportController extends GetxController {
  RxList salesData = [].obs;
  RxList filteredSalesData = [].obs;
  var isLoading = false.obs;

  Future<void> fetchSalesReport() async {
    final response = await http
        .get(Uri.parse('https://rdo-app-o955y.ondigitalocean.app/sales'));

    if (response.statusCode == 200) {
      salesData.value = json.decode(response.body)['Data'];
    } else {
      throw Exception('Failed to load sales report');
    }
  }

  bool isSnackbarActive = false;

  Future<void> sendSalesReport(
      DateController date, List<dynamic> selectedItems) async {
    isLoading(true);

    try {
      final response = await http.post(
        Uri.parse('https://rdo-app-o955y.ondigitalocean.app/sales'),
        body: jsonEncode({
          "date": date.date.value,
          "item": selectedItems,
        }),
      );
      isLoading(false);

      if (response.statusCode == 200) {
        selectedItems.clear();
        date.clear();

        if (!isSnackbarActive) {
          isSnackbarActive = true;
          Get.snackbar(
            'Berhasil',
            'Laporan berhasil dikirim',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Warna.main,
            colorText: Warna.teksactive,
          );
        }
      } else {
        print('${response.body}');
        if (!isSnackbarActive) {
          isSnackbarActive = true;
          Get.snackbar(
            'Gagal Mengirim',
            'Terjadi kesalahan. Silahkan isi semua datanya',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Warna.danger,
            colorText: Warna.teksactive,
          );
        }
        print(response.body);
      }
    } catch (e) {
      isLoading(false);
      print('Error: $e');
      if (!isSnackbarActive) {
        isSnackbarActive = true;
        Get.snackbar(
          'Gagal Mengirim',
          'Terjadi kesalahan. Silahkan coba lagi.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Warna.danger,
          colorText: Warna.teksactive,
        );
      }
    } finally {
      isLoading(false);
      Future.delayed(Duration(seconds: 5), () {
        isSnackbarActive = false;
      });
    }
  }

  @override
  void onInit() {
    fetchSalesReports();
    super.onInit();
  }

  void fetchSalesReports() async {
    try {
      isLoading(true);
      var response = await http
          .get(Uri.parse('https://rdo-app-o955y.ondigitalocean.app/sales'));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        Iterable salesReportsJson = jsonResponse['Data'];
        salesData.assignAll(salesReportsJson
            .map((model) => SalesReport.fromJson(model))
            .toList());
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } finally {
      isLoading(false);
    }
  }
}


