import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_ta/Pages/laporan_page/tab_penjualan/daftar/itemselection.dart';
import 'package:project_ta/Pages/laporan_page/widget/widget.dart';
import 'dart:convert';
import 'package:project_ta/Pages/rekap_laporan_page/models/salesreportmodel.dart';
import 'package:project_ta/color.dart';

class SalesReportController extends GetxController {
  RxList salesData = <SalesReport>[].obs; // Menentukan tipe secara eksplisit
  RxList filteredSalesData = <SalesReport>[].obs; // Menentukan tipe secara eksplisit
  var isLoading = false.obs;
  bool isSnackbarActive = false;

  Future<void> sendSalesReport(DateController date, List<dynamic> selectedItems) async {
    isLoading.value = true; // Set isLoading ke true

    try {
      final response = await http.post(
        Uri.parse('https://rdo-app-o955y.ondigitalocean.app/sales'),
        headers: {"Content-Type": "application/json"}, // Tambahkan headers
        body: jsonEncode({
          "date": date.apiDate.value,
          "item": selectedItems,
        }),
      );

      // Set isLoading ke false setelah mendapatkan respons
      isLoading.value = false;

      if (response.statusCode == 200) {
        selectedItems.clear();
        date.clear();
        Get.find<ItemSelectionController>().resetAllQuantities();

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
      isLoading.value = false;
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
      isLoading.value = false;
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
      isLoading.value = true;
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
      isLoading.value = false;
    }
  }
}
