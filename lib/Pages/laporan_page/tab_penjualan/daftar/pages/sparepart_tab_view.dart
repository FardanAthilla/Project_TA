import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_sparepart.dart';
import 'package:project_ta/Pages/daftar_page/models/Sparepart/model_sparepart.dart';
import 'package:project_ta/Pages/laporan_page/tab_penjualan/daftar/itemselection.dart';
import 'package:project_ta/Pages/laporan_page/models/model_selection_item.dart';
import 'package:project_ta/color.dart';

class SparepartTabView extends StatefulWidget {
  final ItemSelectionController itemSelectionController;

  const SparepartTabView({Key? key, required this.itemSelectionController})
      : super(key: key);

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
      (cat) => cat.categorySparepartId == item.categorySparepartId,
      orElse: () => CategorySparepart(
        categorySparepartId: 0,
        categorySparepartName: 'Kategori Belum Ditemukan',
      ),
    );

    final isOutOfStock = item.quantity == 0;

    return Opacity(
      opacity: isOutOfStock ? 0.5 : 1.0, // Mengatur transparansi
      child: Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: isOutOfStock ? Colors.grey.shade200 : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: ColorFiltered(
                colorFilter: isOutOfStock
                    ? const ColorFilter.mode(Colors.grey, BlendMode.saturation)
                    : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                child: Image.asset(
                  'Assets/iconsparepart.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
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
                      fontSize: 15,
                      color: isOutOfStock ? Colors.grey : Warna.hitam,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.categorySparepartName,
                    style: TextStyle(
                      color: isOutOfStock ? Colors.grey : Warna.card,
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rp.${item.price}',
                    style: TextStyle(
                      fontSize: 12,
                      color: isOutOfStock ? Colors.grey : Warna.teks,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (item.quantity > 0) ...[
              widget.itemSelectionController.selectedQuantitiesSparepart[item.sparepartItemsId] ==
                      null
                  ? IconButton(
                      icon: const Icon(Icons.add, size: 20),
                      onPressed: () {
                        setState(() {
                          widget.itemSelectionController.updateQuantitySparepart(item.sparepartItemsId, 1);
                          widget.itemSelectionController.showBottomBarSparepart.value = true;
                        });
                      },
                    )
                  : Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, color: Warna.danger, size: 20),
                          onPressed: () {
                            setState(() {
                              if (widget.itemSelectionController.selectedQuantitiesSparepart[item.sparepartItemsId]! > 1) {
                                widget.itemSelectionController.updateQuantitySparepart(
                                  item.sparepartItemsId,
                                  widget.itemSelectionController.selectedQuantitiesSparepart[item.sparepartItemsId]! - 1,
                                );
                              } else {
                                widget.itemSelectionController.removeQuantitySparepart(item.sparepartItemsId);
                                widget.itemSelectionController.deselectItem(
                                  SelectedItems(
                                    categoryItemsId: item.categorySparepartId,
                                    category: 'spare_part',
                                    id: item.sparepartItemsId,
                                    item: item.sparepartItemsName,
                                    price: item.price,
                                    quantity: 0,
                                  ),
                                  item.sparepartItemsId,
                                );
                                if (widget.itemSelectionController.selectedQuantitiesSparepart.isEmpty) {
                                  widget.itemSelectionController.showBottomBarSparepart.value = false;
                                }
                              }
                            });
                          },
                        ),
                        Text(
                          widget.itemSelectionController.selectedQuantitiesSparepart[item.sparepartItemsId].toString(),
                          style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Warna.main),
                          onPressed: () {
                            setState(() {
                              if (widget.itemSelectionController.selectedQuantitiesSparepart[item.sparepartItemsId]! < item.quantity) {
                                widget.itemSelectionController.updateQuantitySparepart(
                                  item.sparepartItemsId,
                                  widget.itemSelectionController.selectedQuantitiesSparepart[item.sparepartItemsId]! + 1,
                                );
                              }
                            });
                          },
                        ),
                      ],
                    ),
            ] else
              const Text(
                'Stok Habis',
                style: TextStyle(fontSize: 12),
              ),
          ],
        ),
      ),
    );
  },
);

            }),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return AnimatedSlide(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          offset: widget.itemSelectionController.showBottomBarSparepart.value
              ? Offset.zero
              : const Offset(0, 1),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: widget.itemSelectionController.showBottomBarSparepart.value
                ? 1.0
                : 0.0,
            child: widget.itemSelectionController.showBottomBarSparepart.value
                ? BottomAppBar(
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          int totalItems = widget.itemSelectionController
                              .selectedQuantitiesSparepart.values
                              .fold(0, (prev, element) => prev + element);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0, left: 16.0, bottom: 16.0),
                                child: Text(
                                  'Total Barang: $totalItems',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16, top: 6, bottom: 6),
                          child: SizedBox(
                            width: 125,
                            child: ElevatedButton(
                              onPressed: () {
                                for (var item
                                    in sparepartController.storeItems) {
                                  if (widget.itemSelectionController
                                      .selectedQuantitiesSparepart
                                      .containsKey(item.sparepartItemsId)) {
                                    var selectedQuantity = widget
                                            .itemSelectionController
                                            .selectedQuantitiesSparepart[
                                        item.sparepartItemsId]!;
                                    var selectedItem = SelectedItems(
                                      categoryItemsId: item.categorySparepartId,
                                      category: "spare_part",
                                      id: item.sparepartItemsId,
                                      item: item.sparepartItemsName,
                                      price: item.price,
                                      quantity: selectedQuantity,
                                    );
                                    widget.itemSelectionController
                                        .selectItem(selectedItem);
                                    Get.back();
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              child: Text(
                                'Tambah',
                                style: TextStyle(color: Warna.main),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        );
      }),
    );
  }
}
