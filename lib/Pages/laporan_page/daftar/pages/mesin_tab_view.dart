import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_mesin.dart';
import 'package:project_ta/Pages/daftar_page/models/Mesin/model_mesin.dart';
import 'package:project_ta/Pages/laporan_page/daftar/itemselection.dart';
import 'package:project_ta/Pages/laporan_page/models/model_selection_item.dart';
import 'package:project_ta/color.dart';

class MesinTabView extends StatefulWidget {
  final ItemSelectionController itemSelectionController;

  const MesinTabView({Key? key, required this.itemSelectionController}) : super(key: key);

  @override
  _MesinTabViewState createState() => _MesinTabViewState();
}

class _MesinTabViewState extends State<MesinTabView> {
  final StoreController storeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 48,
              child: TextField(
                controller: storeController.searchControllerReport,
                decoration: const InputDecoration(
                  hintText: 'Cari sekarang...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  ),
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(vertical: 14.0),
                ),
                onChanged: (query) {
                  storeController.ItemSelect(query);
                },
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (storeController.itemSelect.isEmpty) {
                return const Center(
                  child: Text(
                    'Barang tidak ditemukan',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: storeController.itemSelect.length,
                itemBuilder: (context, index) {
                  final item = storeController.itemSelect[index];
                  final category = storeController.categories.firstWhere(
                    (cat) => cat.categoryMachineId == item.categoryMachineId,
                    orElse: () => CategoryMachine(
                      categoryMachineId: 0,
                      categoryMachineName: 'Unknown Category',
                    ),
                  );
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                'Assets/iconlistmesin3.png',
                                width: 80,
                                height: 80,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.storeItemsName,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Warna.hitam,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    category.categoryMachineName,
                                    style: TextStyle(
                                      color: Warna.card,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Rp.${item.price}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Warna.teks,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            item.quantity > 0
                                ? widget.itemSelectionController.selectedQuantities[item.storeItemsId] == null
                                    ? IconButton(
                                        icon: const Icon(
                                          Icons.add,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            widget.itemSelectionController.updateQuantityMachine(item.storeItemsId, 1);
                                            widget.itemSelectionController.showBottomBar.value = true;
                                          });
                                        },
                                      )
                                    : Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.remove,
                                              color: Warna.danger,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                if (widget.itemSelectionController.selectedQuantities[item.storeItemsId]! > 1) {
                                                  widget.itemSelectionController.updateQuantityMachine(item.storeItemsId,
                                                      widget.itemSelectionController.selectedQuantities[item.storeItemsId]! - 1);
                                                } else {
                                                  widget.itemSelectionController.removeQuantityMachine(item.storeItemsId);
                                                  widget.itemSelectionController.deselectItem(
                                                     SelectedItems(
                                                       categoryItemsId: item.categoryMachineId,
                                                       category: 'mesin',
                                                       id: item.storeItemsId,
                                                       item: item.storeItemsName,
                                                       price: item.price,
                                                       quantity: 0,
                                                     ), 
                                                     item.storeItemsId,
                                                   );
                                                  if (widget.itemSelectionController.selectedQuantities.isEmpty) {
                                                    widget.itemSelectionController.showBottomBar.value = false;
                                                  }
                                                }
                                              });
                                            },
                                          ),
                                          Text(
                                            widget.itemSelectionController.selectedQuantities[item.storeItemsId].toString(),
                                            style: const TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.add, color: Warna.main),
                                            onPressed: () {
                                              setState(() {
                                                if (widget.itemSelectionController.selectedQuantities[item.storeItemsId]! < item.quantity) {
                                                  widget.itemSelectionController.updateQuantityMachine(item.storeItemsId,
                                                      widget.itemSelectionController.selectedQuantities[item.storeItemsId]! + 1);
                                                }
                                              });
                                            },
                                          ),
                                        ],
                                      )
                                : const Text(
                                    'Stok Habis',
                                    style: TextStyle(fontSize: 12),
                                  ),
                          ],
                        ),
                      ),
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                      ),
                    ],
                  );
                },
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return widget.itemSelectionController.showBottomBar.value
            ? BottomAppBar(
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                       int totalItems= widget.itemSelectionController.selectedQuantities.values.fold(0, (prev, element) => prev + element);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Barang: $totalItems',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          );
                        }),
                      ElevatedButton(
                        onPressed: () {
                          for (var item in storeController.storeItems) {
                            if (widget.itemSelectionController.selectedQuantities.containsKey(item.storeItemsId)) {
                              var selectedQuantity = widget.itemSelectionController.selectedQuantities[item.storeItemsId]!;
                              var selectedItem = SelectedItems(
                                categoryItemsId: item.categoryMachineId,
                                category: "mesin",
                                id: item.storeItemsId,
                                item: item.storeItemsName,
                                price: item.price,
                                quantity: selectedQuantity,
                              );
                              widget.itemSelectionController.selectItem(selectedItem);
                              Get.back();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                        child: Text(
                          'Tambah',
                          style: TextStyle(color: Warna.main),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink();
      }),
    );
  }
}
