import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_sparepart.dart';
import 'package:project_ta/Pages/laporan_page/models/model_selection_item.dart';
import 'package:project_ta/Pages/laporan_page/tab_penjualan/daftar/itemselection.dart';
import 'package:project_ta/Pages/laporan_page/tab_service/edit/edit_controller.dart';
import 'package:project_ta/Pages/profile_page/profile_controller.dart';
import 'package:project_ta/Pages/laporan_page/controllers/controllerservice.dart';
import 'package:project_ta/color.dart';
import 'package:project_ta/Pages/laporan_page/tab_service/edit/add_sparepart.dart';
import 'package:project_ta/Pages/laporan_page/widget/widget.dart';

class EditPage extends StatelessWidget {
  final EditPageController controller;
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ServiceReportController serviceController = Get.put(ServiceReportController());
  final ProfileController profileController = Get.put(ProfileController());
  final SparepartController sparepartController = Get.put(SparepartController());


  EditPage({
    super.key,
    required dynamic report,
    required ItemSelectionController itemSelectionController,
  }) : controller = Get.put(EditPageController(
          report: report,
          itemSelectionController: itemSelectionController,
        ));

  @override
  Widget build(BuildContext context) {
    final userId = profileController.userData?['user_id'] ?? 0;
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
                  controller: controller.nameController,
                  maxLines: 1,
                ),
                ReadOnlyTextField(
                  title: 'Nama Mesin Yang Diperbaiki',
                  controller: controller.machineNameController,
                  maxLines: 1,
                ),
                EditableTextField(
                  title: 'Biaya Perbaikan',
                  controller: controller.priceController,
                  maxLength: 20,
                  inputType: TextInputType.number,
                  subtitle: "Masukkan Biaya",
                ),
                EditableTextField(
                  title: 'Keluhan Yang Di Alami',
                  controller: controller.complainController,
                  maxLines: 4,
                  maxLength: 120,
                  subtitle: "Keluhan Yang Dialami",
                ),
                GestureDetector(
                  onTap: () {
                    final itemSelectionServiceController = Get.find<ItemSelectionController>();
                    Get.to(() => AddSparepartService(itemSelectionServiceController: itemSelectionServiceController));
                    sparepartController.SparePartSelectService(sparepartController.searchControllerService.text);
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
                  if (controller.itemSelectionController.selectedItemsSparepartService.isEmpty) {
                    return const SizedBox.shrink();
                  } else {
                    return Column(
                      children: [
                        ...controller.itemSelectionController
                            .selectedItemsSparepartService
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
                                      controller.itemSelectionController
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottomBarButton(
                      text: 'Bersihkan',
                      backgroundColor: Colors.white,
                      textColor: Warna.danger,
                      borderColor: Warna.danger,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Konfirmasi',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                'Apakah Anda yakin untuk membersihkannya?',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Batal',
                                    style: TextStyle(
                                      color: Warna.main,
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'Ya',
                                    style: TextStyle(
                                      color: Warna.main,
                                    ),
                                  ),
                                  onPressed: () {
                                    controller.resetForm();
                                    Get.back();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    ValueListenableBuilder<bool>(
                      valueListenable: controller.isLoading,
                      builder: (context, value, child) {
                        return BottomBarButton(
                          text: value ? 'Mengirim...' : 'Kirim',
                          backgroundColor: Warna.main,
                          textColor: Colors.white,
                          borderColor: value
                              ? Color.fromARGB(151, 203, 203, 203)
                              : Warna.main,
                          onPressed: value
                              ? null
                              : () async {
                                  if (controller.isFormValid()) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Konfirmasi',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          content: Text(
                                            'Apakah Anda yakin untuk mengirimkan laporan penjualan?',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text(
                                                'Batal',
                                                style: TextStyle(
                                                  color: Warna.main,
                                                ),
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              },
                                            ),
                                            TextButton(
                                              child: Text(
                                                'Ya',
                                                style: TextStyle(
                                                  color: Warna.main,
                                                ),
                                              ),
                                              onPressed: () async {
                                                Get.back();
                                                controller.isLoading.value = true;
                                                await controller.sendDataToApi(userId);
                                                controller.resetForm();
                                                controller.isLoading.value = false;
                                                serviceController.fetchServiceReports();
                                                
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    Get.snackbar(
                                      'Error',
                                      'Semua data harus diisi',
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}