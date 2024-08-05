import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_ta/Pages/laporan_page/tab_penjualan/daftar/itemselection.dart';
import 'package:project_ta/Pages/laporan_page/widget/widget.dart';
import 'dart:convert';
import 'package:project_ta/Pages/rekap_laporan_page/models/salesreportmodel.dart';
import 'package:project_ta/color.dart';

class SalesReportController extends GetxController {
  RxList salesData = <SalesReport>[].obs; 
  RxList filteredSalesData = <SalesReport>[].obs;
  var isLoading = false.obs;
  bool isSnackbarActive = false;

  Future<void> sendSalesReport(DateController date, List<dynamic> selectedItems) async {
    isLoading.value = true; 

    try {
      final response = await http.post(
        Uri.parse('https://rdo-app-o955y.ondigitalocean.app/sales'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "date": date.apiDate.value,
          "item": selectedItems,
        }),
      );

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
}
