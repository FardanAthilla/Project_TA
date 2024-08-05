import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_ta/Pages/laporan_page/tab_penjualan/daftar/itemselection.dart';
import 'package:project_ta/Pages/laporan_page/controllers/controllerservice.dart';
import 'package:project_ta/color.dart';

class EditPageController extends GetxController {
  final ItemSelectionController itemSelectionController;
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final dynamic report;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController machineNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController complainController = TextEditingController();
  final ServiceReportController serviceController =
      Get.put(ServiceReportController());

  EditPageController({
    required this.report,
    required this.itemSelectionController,
  }) {
    complainController.text = report.complaints ?? '';
    nameController.text = report.name ?? '';
    machineNameController.text = report.machineName ?? '';
  }

  Future<void> sendDataToApi(int userId) async {
    final url = 'https://rdo-app-o955y.ondigitalocean.app/service';

    final Map<String, dynamic> data = {
      "id": report.serviceReportId,
      "complaints": complainController.text,
      "total_price": calculateTotalPrice(),
      "item":
          itemSelectionController.selectedItemsSparepartService.map((entry) {
        return {
          "id": entry.id,
          "item": entry.item,
          "price": entry.price,
          "category": entry.category,
          "category_items_id": entry.categoryItemsId,
          "quantity": entry.quantity,
        };
      }).toList(),
    };

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        serviceController.fetchServiceReportsByUserId(userId);
        Get.back();
        Get.snackbar(
          'Berhasil',
          'Data berhasil dikirim!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Warna.main,
          colorText: Warna.teksactive,
        );
        print('Data berhasil dikirim!');
      } else {
        Get.snackbar(
          'Gagal',
          'Gagal mengirim data: ${response.body}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Warna.danger,
          colorText: Warna.teksactive,
        );
        print('Gagal mengirim data: ${response.body}');
      }
    } catch (e) {
      Get.snackbar(
        'Gagal mengirim data',
        'Gagal mengirim data: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Warna.danger,
        colorText: Warna.teksactive,
      );
      print('Gagal mengirim data: $e');
    }
  }

  int calculateTotalPrice() {
    int total = 0;
    for (var entry in itemSelectionController.selectedItemsSparepartService) {
      total += entry.price * entry.quantity;
    }
    return total;
  }

  bool isFormValid() {
    return nameController.text.isNotEmpty &&
        machineNameController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        complainController.text.isNotEmpty;
  }

  void resetForm() {
    itemSelectionController.resetAllQuantitiesService();
    itemSelectionController.selectedItemsSparepartService.clear();
  }
}
