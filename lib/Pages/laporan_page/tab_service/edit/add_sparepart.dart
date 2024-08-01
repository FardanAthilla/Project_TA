import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_sparepart.dart';
import 'package:project_ta/Pages/daftar_page/models/Sparepart/model_sparepart.dart';
import 'package:project_ta/Pages/laporan_page/tab_penjualan/daftar/itemselection.dart';
import 'package:project_ta/Pages/laporan_page/models/model_selection_item.dart';
import 'package:project_ta/color.dart';

class AddSparepartService extends StatefulWidget {
  final ItemSelectionController itemSelectionServiceController;

  const AddSparepartService(
      {Key? key, required this.itemSelectionServiceController})
      : super(key: key);

  @override
  _SparepartTabViewState createState() => _SparepartTabViewState();
}

class _SparepartTabViewState extends State<AddSparepartService> {
  final SparepartController sparepartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pilih Barang'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 48,
                child: TextField(
                  controller: sparepartController.searchControllerService,
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
                    sparepartController.SparePartSelectService(query);
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
                      (cat) =>
                          cat.categorySparepartId == item.categorySparepartId,
                      orElse: () => CategorySparepart(
                        categorySparepartId: 0,
                        categorySparepartName: 'Kategori Belum Ditemukan',
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
                                  ? widget.itemSelectionServiceController
                                                  .selectedQuantitiesSparepartService[
                                              item.sparepartItemsId] ==
                                          null
                                      ? IconButton(
                                          icon: const Icon(
                                            Icons.add,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              widget
                                                  .itemSelectionServiceController
                                                  .updateQuantitySparepartService(
                                                      item.sparepartItemsId, 1);
                                              widget
                                                  .itemSelectionServiceController
                                                  .showBottomBarSparepartService
                                                  .value = true;
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
                                                  if (widget.itemSelectionServiceController
                                                              .selectedQuantitiesSparepartService[
                                                          item.sparepartItemsId]! >
                                                      1) {
                                                    widget
                                                        .itemSelectionServiceController
                                                        .updateQuantitySparepartService(
                                                            item
                                                                .sparepartItemsId,
                                                            widget.itemSelectionServiceController
                                                                        .selectedQuantitiesSparepartService[
                                                                    item.sparepartItemsId]! -
                                                                1);
                                                  } else {
                                                    widget
                                                        .itemSelectionServiceController
                                                        .removeQuantitySparepartService(
                                                            item.sparepartItemsId);
                                                    widget
                                                        .itemSelectionServiceController
                                                        .deselectItemSparepartService(
                                                      SelectedItems(
                                                        categoryItemsId: item
                                                            .categorySparepartId,
                                                        category: 'spare_part',
                                                        id: item
                                                            .sparepartItemsId,
                                                        item: item
                                                            .sparepartItemsName,
                                                        price: item.price,
                                                        quantity: 0,
                                                      ),
                                                      item.sparepartItemsId,
                                                    );

                                                    if (widget
                                                        .itemSelectionServiceController
                                                        .selectedQuantitiesSparepartService
                                                        .isEmpty) {
                                                      widget
                                                          .itemSelectionServiceController
                                                          .showBottomBarSparepartService
                                                          .value = false;
                                                    }
                                                  }
                                                });
                                              },
                                            ),
                                            Text(
                                              widget
                                                  .itemSelectionServiceController
                                                  .selectedQuantitiesSparepartService[
                                                      item.sparepartItemsId]
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.add,
                                                  color: Warna.main),
                                              onPressed: () {
                                                setState(() {
                                                  if (widget.itemSelectionServiceController
                                                              .selectedQuantitiesSparepartService[
                                                          item.sparepartItemsId]! <
                                                      item.quantity) {
                                                    widget
                                                        .itemSelectionServiceController
                                                        .updateQuantitySparepartService(
                                                            item
                                                                .sparepartItemsId,
                                                            widget.itemSelectionServiceController
                                                                        .selectedQuantitiesSparepartService[
                                                                    item.sparepartItemsId]! +
                                                                1);
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
          return AnimatedSlide(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            offset: widget.itemSelectionServiceController
                    .showBottomBarSparepartService.value
                ? Offset.zero
                : const Offset(0, 1),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: widget.itemSelectionServiceController
                      .showBottomBarSparepartService.value
                  ? 1.0
                  : 0.0,
              child: widget.itemSelectionServiceController
                      .showBottomBarSparepartService.value
                  ? BottomAppBar(
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            int totalItems = widget
                                .itemSelectionServiceController
                                .selectedQuantitiesSparepartService
                                .values
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
                                    if (widget.itemSelectionServiceController
                                        .selectedQuantitiesSparepartService
                                        .containsKey(item.sparepartItemsId)) {
                                      var selectedQuantity = widget
                                              .itemSelectionServiceController
                                              .selectedQuantitiesSparepartService[
                                          item.sparepartItemsId]!;
                                      var selectedItemsSparepartService =
                                          SelectedItems(
                                        categoryItemsId:
                                            item.categorySparepartId,
                                        category: "spare_part",
                                        id: item.sparepartItemsId,
                                        item: item.sparepartItemsName,
                                        price: item.price,
                                        quantity: selectedQuantity,
                                      );
                                      widget.itemSelectionServiceController
                                          .selectItemSparepartService(
                                              selectedItemsSparepartService);
                                    }
                                  }
                                  Get.back();
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
      ),
    );
  }
}
