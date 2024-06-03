  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:project_ta/Pages/daftar_page/controllers/controller_sparepart.dart';
  import 'package:project_ta/Pages/daftar_page/models/Sparepart/model_sparepart.dart';
  import 'package:project_ta/Pages/laporan_page/daftar/itemselection.dart';
  import 'package:project_ta/Pages/laporan_page/models/model_selection_item.dart';
  import 'package:project_ta/color.dart';

  class SparepartTabView extends StatefulWidget {
    final ItemSelectionController itemSelectionController;

    const SparepartTabView({Key? key, required this.itemSelectionController}) : super(key: key);

    @override
    _SparepartTabViewState createState() => _SparepartTabViewState();
  }

  class _SparepartTabViewState extends State<SparepartTabView> {
    final SparepartController sparepartController = Get.find();
    
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
                  controller: sparepartController.searchControllerReport,
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
                  onSubmitted: (query) {
                    sparepartController.SparePartSelect(query);
                  },
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (sparepartController.sparePartSelect.isEmpty) {
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
                  itemCount: sparepartController.sparePartSelect.length,
                  itemBuilder: (context, index) {
                    final item = sparepartController.sparePartSelect[index];
                    final category = sparepartController.categories.firstWhere(
                      (cat) => cat.categorySparepartId == item.sparepartItemsId,
                      orElse: () => CategorySparepart(
                        categorySparepartId: 0,
                        categorySparepartName: 'Unknown Category',
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
                                  'Assets/iconsparepart.png',
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
                                      item.sparepartItemsName,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Warna.hitam,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      category.categorySparepartName,
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
                                  ? widget.itemSelectionController.selectedQuantitiesSparepart[item.sparepartItemsId] == null
                                      ? IconButton(
                                          icon: const Icon(
                                            Icons.add,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              widget.itemSelectionController.updateQuantitySparepart(item.sparepartItemsId, 1);
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
                                                  if (widget.itemSelectionController.selectedQuantitiesSparepart[item.sparepartItemsId]! > 1) {
                                                    widget.itemSelectionController.updateQuantitySparepart(item.sparepartItemsId,
                                                        widget.itemSelectionController.selectedQuantitiesSparepart[item.sparepartItemsId]! - 1);
                                                  } else {
                                                    widget.itemSelectionController.removeQuantitySparepart(item.sparepartItemsId);
                                                    if (widget.itemSelectionController.selectedQuantitiesSparepart.isEmpty) {
                                                      widget.itemSelectionController.showBottomBar.value = false;
                                                    }
                                                  }
                                                });
                                              },
                                            ),
                                            Text(
                                              widget.itemSelectionController.selectedQuantitiesSparepart[item.sparepartItemsId].toString(),
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
                                                  if (widget.itemSelectionController.selectedQuantitiesSparepart[item.sparepartItemsId]! < item.quantity) {
                                                    widget.itemSelectionController.updateQuantitySparepart(item.sparepartItemsId,
                                                        widget.itemSelectionController.selectedQuantitiesSparepart[item.sparepartItemsId]! + 1);
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
                        int totalItems = sparepartController.sparePartSelect.fold(0, (sum, item) {
                          if (widget.itemSelectionController.selectedQuantitiesSparepart.containsKey(item.sparepartItemsId)) {
                            return sum + widget.itemSelectionController.selectedQuantitiesSparepart[item.sparepartItemsId]!;
                          }
                          return sum;
                        });
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
                            for (var item in sparepartController.sparePartSelect) {
                              if (widget.itemSelectionController.selectedQuantitiesSparepart.containsKey(item.sparepartItemsId)) {
                                var selectedQuantity = widget.itemSelectionController.selectedQuantitiesSparepart[item.sparepartItemsId]!;
                                var selectedItem = SelectedItems(
                                  categoryItemsId: item.categorySparepartId,
                                  category: "spare_part",
                                  id: item.sparepartItemsId,
                                  item: item.sparepartItemsName,
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