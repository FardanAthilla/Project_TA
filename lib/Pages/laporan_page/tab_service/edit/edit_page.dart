import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/laporan_page/models/model_selection_item.dart';
import 'package:project_ta/Pages/laporan_page/tab_penjualan/daftar/itemselection.dart';
import 'package:project_ta/Pages/laporan_page/tab_service/edit/add_sparepart.dart';
import 'package:project_ta/Pages/laporan_page/widget/widget.dart';
import 'package:project_ta/color.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatelessWidget {
  final ItemSelectionController itemSelectionController;
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final dynamic report;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController machineNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController complainController = TextEditingController();

  EditPage({
    super.key,
    required this.report,
    required this.itemSelectionController,
  }) {
    complainController.text = report.complaints ?? '';
    nameController.text = report.name ?? '';
    machineNameController.text = report.machineName ?? '';
  }

  void _showInputDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Input Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Report ID: ${report.serviceReportId}'),
                SizedBox(height: 8),
                Text('Nama Pelanggan: ${nameController.text}'),
                SizedBox(height: 8),
                Text('Nama Mesin: ${machineNameController.text}'),
                SizedBox(height: 8),
                Text('Biaya Perbaikan: ${priceController.text}'),
                SizedBox(height: 8),
                Text('Keluhan: ${complainController.text}'),
                SizedBox(height: 16),
                Text('Barang Yang Dipilih:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: itemSelectionController
                      .selectedItemsSparepartService
                      .map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                          '${entry.item} - Rp.${entry.price} x ${entry.quantity}'),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () async {
                await _sendDataToApi();
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendDataToApi() async {
    final url = 'https://rdo-app-o955y.ondigitalocean.app/service';

    final Map<String, dynamic> data = {
      "id": report.serviceReportId,
      "complaints": complainController.text,
      "total_price": _calculateTotalPrice(),
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
        print('Data berhasil dikirim!');
      } else {
        print('Gagal mengirim data: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  int _calculateTotalPrice() {
    int total = 0;
    for (var entry in itemSelectionController.selectedItemsSparepartService) {
      total += entry.price * entry.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Laporan Service'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                ReadOnlyTextField(
                  title: 'Nama Pelanggan',
                  controller: nameController,
                  maxLines: 1,
                ),
                ReadOnlyTextField(
                  title: 'Nama Mesin Yang Diperbaiki',
                  controller: machineNameController,
                  maxLines: 1,
                ),
                EditableTextField(
                  title: 'Biaya Perbaikan',
                  controller: priceController,
                  maxLength: 20,
                  inputType: TextInputType.number,
                  subtitle: "Masukkan Biaya",
                ),
                EditableTextField(
                  title: 'Keluhan Yang Di Alami',
                  controller: complainController,
                  maxLines: 4,
                  maxLength: 120,
                  subtitle: "Keluhan Yang Dialami",
                ),
                GestureDetector(
                  onTap: () {
                    final itemSelectionServiceController =
                        Get.find<ItemSelectionController>();
                    Get.to(() => AddSparepartService(
                        itemSelectionServiceController:
                            itemSelectionServiceController));
                            
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 0.5,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Daftar Barang'),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Obx(() {
                  if (itemSelectionController
                      .selectedItemsSparepartService.isEmpty) {
                    return const SizedBox.shrink();
                  } else {
                    return Column(
                      children: [
                        ...itemSelectionController.selectedItemsSparepartService
                            .map((entry) {
                          final item = entry.item;
                          final quantity = entry.quantity;
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Warna.teksactive,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 1.0,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        child: Image.asset(
                                          entry.category == "mesin"
                                              ? 'Assets/iconlistmesin3.png'
                                              : 'Assets/iconsparepart.png',
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Warna.hitam,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              ('Rp.${entry.price} x $quantity'),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Warna.teks,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Warna.danger,
                                    ),
                                    onPressed: () {
                                      itemSelectionController
                                          .deselectItemSparepartService(
                                              SelectedItems(
                                                categoryItemsId:
                                                    entry.categoryItemsId,
                                                category:
                                                    entry.category == "mesin"
                                                        ? "mesin"
                                                        : "spare_part",
                                                price: entry.price,
                                                id: entry.id,
                                                item: item,
                                                quantity: 1,
                                              ),
                                              (entry.id));
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                            ],
                          );
                        }).toList(),
                      ],
                    );
                  }
                }),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _showInputDetails(context),
                  child: Text('Show Input Details'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
