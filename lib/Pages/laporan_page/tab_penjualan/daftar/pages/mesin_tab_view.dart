import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_mesin.dart';
import 'package:project_ta/Pages/daftar_page/models/Mesin/model_mesin.dart';
import 'package:project_ta/Pages/laporan_page/tab_penjualan/daftar/itemselection.dart';
import 'package:project_ta/Pages/laporan_page/models/model_selection_item.dart';
import 'package:project_ta/color.dart';

class MesinTabView extends StatefulWidget {
  final ItemSelectionController itemSelectionController;

  const MesinTabView({Key? key, required this.itemSelectionController})
      : super(key: key);

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
                onSubmitted: (query) {
                  storeController.ItemSelect(query);
                },
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (storeController.itemSelect.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: Lottie.asset(
                          'Assets/kotak.json',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Text(
                        'Barang tidak ditemukan',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
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
                      categoryMachineName: 'Kategori Belum Ditemukan',
                    ),
                  );

                  final isOutOfStock = item.quantity == 0;

                  return Opacity(
                    opacity: isOutOfStock ? 0.5 : 1.0, // Mengatur transparansi
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: isOutOfStock
                            ? Colors.grey.shade200
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: ColorFiltered(
                              colorFilter: isOutOfStock
                                  ? ColorFilter.mode(
                                      Colors.grey, BlendMode.saturation)
                                  : ColorFilter.mode(
                                      Colors.transparent, BlendMode.multiply),
                              child: Image.asset(
                                'Assets/iconlistmesin3.png',
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
                                  item.storeItemsName,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: isOutOfStock
                                        ? Colors.grey
                                        : Warna.hitam,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category.categoryMachineName,
                                  style: TextStyle(
                                    color:
                                        isOutOfStock ? Colors.grey : Warna.card,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Rp.${item.price}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        isOutOfStock ? Colors.grey : Warna.teks,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (item.quantity > 0) ...[
                            widget.itemSelectionController.selectedQuantities[
                                        item.storeItemsId] ==
                                    null
                                ? IconButton(
                                    icon: const Icon(Icons.add, size: 20),
                                    onPressed: () {
                                      setState(() {
                                        widget.itemSelectionController
                                            .updateQuantityMachine(
                                                item.storeItemsId, 1);
                                        widget.itemSelectionController
                                            .showBottomBar.value = true;
                                      });
                                    },
                                  )
                                : Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove,
                                            color: Warna.danger, size: 20),
                                        onPressed: () {
                                          setState(() {
                                            if (widget.itemSelectionController
                                                        .selectedQuantities[
                                                    item.storeItemsId]! >
                                                1) {
                                              widget.itemSelectionController
                                                  .updateQuantityMachine(
                                                      item.storeItemsId,
                                                      widget.itemSelectionController
                                                                  .selectedQuantities[
                                                              item.storeItemsId]! -
                                                          1);
                                            } else {
                                              widget.itemSelectionController
                                                  .removeQuantityMachine(
                                                      item.storeItemsId);
                                              widget.itemSelectionController
                                                  .deselectItem(
                                                SelectedItems(
                                                  categoryItemsId:
                                                      item.categoryMachineId,
                                                  category: 'mesin',
                                                  id: item.storeItemsId,
                                                  item: item.storeItemsName,
                                                  price: item.price,
                                                  quantity: 0,
                                                ),
                                                item.storeItemsId,
                                              );
                                              if (widget.itemSelectionController
                                                  .selectedQuantities.isEmpty) {
                                                widget
                                                    .itemSelectionController
                                                    .showBottomBar
                                                    .value = false;
                                              }
                                            }
                                          });
                                        },
                                      ),
                                      Text(
                                        widget
                                            .itemSelectionController
                                            .selectedQuantities[
                                                item.storeItemsId]
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87),
                                      ),
                                      IconButton(
                                        icon:
                                            Icon(Icons.add, color: Warna.main),
                                        onPressed: () {
                                          setState(() {
                                            if (widget.itemSelectionController
                                                        .selectedQuantities[
                                                    item.storeItemsId]! <
                                                item.quantity) {
                                              widget.itemSelectionController
                                                  .updateQuantityMachine(
                                                      item.storeItemsId,
                                                      widget.itemSelectionController
                                                                  .selectedQuantities[
                                                              item.storeItemsId]! +
                                                          1);
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
          offset: widget.itemSelectionController.showBottomBar.value
              ? Offset.zero
              : const Offset(0, 1),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity:
                widget.itemSelectionController.showBottomBar.value ? 1.0 : 0.0,
            child: widget.itemSelectionController.showBottomBar.value
                ? BottomAppBar(
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          int totalItems = widget
                              .itemSelectionController.selectedQuantities.values
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
                                for (var item in storeController.storeItems) {
                                  if (widget.itemSelectionController
                                      .selectedQuantities
                                      .containsKey(item.storeItemsId)) {
                                    var selectedQuantity = widget
                                        .itemSelectionController
                                        .selectedQuantities[item.storeItemsId]!;
                                    var selectedItem = SelectedItems(
                                      categoryItemsId: item.categoryMachineId,
                                      category: "mesin",
                                      id: item.storeItemsId,
                                      item: item.storeItemsName,
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
