import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_ta/Pages/rekap_laporan_page/controllers/controllerservice.dart';
import 'dart:convert';

import 'package:project_ta/color.dart';

class ServiceController extends GetxController {
  var isLoading = false.obs;
  bool isSnackbarActive = false;
  final ServiceReportController serviceController = Get.put(ServiceReportController());

  Future<void> sendServiceRequest(Map<String, dynamic> request, int userId) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse('https://rdo-app-o955y.ondigitalocean.app/service'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request),
      );

      if (response.statusCode == 200) {
        serviceController.fetchServiceReportsByUserId(userId);
        Get.back();
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
      print('Error: $request');
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
