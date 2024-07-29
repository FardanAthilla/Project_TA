import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServiceController extends GetxController {
  var isLoading = false.obs;

  Future<void> sendServiceRequest(Map<String, dynamic> request) async {
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
        Get.snackbar('Success', 'Service request sent successfully');
      } else {
        throw Exception('Failed to post service');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to send service request');
    } finally {
      isLoading.value = false;
    }
  }
}