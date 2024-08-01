import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_ta/Pages/laporan_page/tab_penjualan/daftar/itemselection.dart';
import 'dart:convert';
import 'package:project_ta/color.dart';

class ServiceReportController extends GetxController {
  var isLoading = false.obs;
  bool isSnackbarActive = false;

  Future<void> sendEditService(
    double id, List<dynamic> selectedItems, double totalPrice, String complaints) async {
    isLoading(true);

    try {
      final response = await http.put(
        Uri.parse('https://rdo-app-o955y.ondigitalocean.app/service'),
        body: jsonEncode({
          "id": id,
          "item": selectedItems,
          "total_price": totalPrice,
          "complaints": complaints
        }),
      );
      isLoading(false);

      if (response.statusCode == 200) {
        selectedItems.clear();
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
}
