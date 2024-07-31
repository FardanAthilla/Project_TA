import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/laporan_page/models/model_selection_item.dart';
import 'package:project_ta/Pages/laporan_page/tab_penjualan/daftar/itemselection.dart';
import 'package:project_ta/Pages/laporan_page/tab_service/edit/add_sparepart.dart';
import 'package:project_ta/color.dart';

class EditPage extends StatelessWidget {
  final ItemSelectionController itemSelectionController;
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final dynamic report;

  EditPage({
    super.key,
    required this.report,
    required this.itemSelectionController,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Edit Laporan Service'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Customer: ${report.name}'),
            Text('Jenis Mesin: ${report.machineName}'),
            Text('Keluhan: ${report.complaints}'),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
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
                                            category: entry.category == "mesin"
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
          ],
        ),
      ),
    ));
  }
}
