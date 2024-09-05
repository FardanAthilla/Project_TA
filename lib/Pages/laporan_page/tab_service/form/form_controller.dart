import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_ta/Pages/laporan_page/controllers/controllerservice.dart';
import 'package:project_ta/color.dart';

class ServiceController extends GetxController {
  var isLoading = false.obs;
  bool isSnackbarActive = false;
  final ServiceReportController serviceController =
      Get.put(ServiceReportController());

  Future<void> sendServiceRequest(
      Map<String, dynamic> request, int userId) async {
    isLoading.value = true;

    try {
      var uri = Uri.parse('https://rdo-app-o955y.ondigitalocean.app/service');
      var requestMultipart = http.MultipartRequest('POST', uri);

      requestMultipart.fields['date'] = request['date'];
      requestMultipart.fields['name'] = request['name'];
      requestMultipart.fields['user_id'] = request['user_id'].toString();
      requestMultipart.fields['machine_name'] = request['machine_name'];
      requestMultipart.fields['complaints'] = request['complaints'];

      if (request['image'] != null) {
        requestMultipart.files
            .add(await http.MultipartFile.fromPath('image', request['image']));
      }

      var streamedResponse = await requestMultipart.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        serviceController.fetchServiceReportsByUserId(userId);
        Get.back();
        if (!isSnackbarActive) {
          Get.back();
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
      print('Gagal mengirim data: $request');
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
