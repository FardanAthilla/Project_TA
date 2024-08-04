import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_mesin.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_sparepart.dart';
import 'package:project_ta/Pages/daftar_page/models/Mesin/model_mesin.dart';
import 'package:project_ta/Pages/daftar_page/Pages/Mesin/filter_mesin.dart';
import 'package:project_ta/Pages/daftar_page/widget/shimmer.dart';
import 'package:project_ta/color.dart';

Widget buildMesinList(BuildContext context, StoreController storeController,
    SparepartController sparepartController) {
  final FocusNode searchFocusNode = FocusNode();
  var isLoading = false.obs;

  Future<void> refreshItems() async {
    isLoading(true);
    storeController.searchItems(storeController.searchController.text);
    storeController.fetchCategories();
    sparepartController.fetchCategories();
    isLoading(false);
  }

  return GestureDetector(
    onTap: () {
      searchFocusNode.unfocus();
    },
    child: Obx(() {
      if (storeController.isLoading.value) {
        return buildShimmer();
      } else {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: TextField(
                        controller: storeController.searchController,
                        focusNode: searchFocusNode,
                        decoration: const InputDecoration(
                          hintText: 'Cari sekarang...',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0)),
                          ),
                          prefixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(vertical: 14.0),
                        ),
                        onSubmitted: (query) {
                          storeController.searchItems(query);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      showFilterModal(context, storeController);
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Warna.main,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.filter_list, color: Warna.background),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Daftar Mesin',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: refreshItems,
                child: Obx(() {
                  if (storeController.filteredItems.isEmpty) {
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
                    itemCount: storeController.filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = storeController.filteredItems[index];
                      final category = storeController.categories.firstWhere(
                        (cat) =>
                            cat.categoryMachineId == item.categoryMachineId,
                        orElse: () => CategoryMachine(
                          categoryMachineId: 0,
                          categoryMachineName: 'Kategori Belum Ditemukan',
                        ),
                      );

                      final isOutOfStock = item.quantity == 0;

                      return Opacity(
                        opacity:
                            isOutOfStock ? 0.5 : 1.0,
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          margin: EdgeInsets.symmetric(
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
                                      : ColorFilter.mode(Colors.transparent,
                                          BlendMode.multiply),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                        color: isOutOfStock
                                            ? Colors.grey
                                            : Warna.card,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Rp.${item.price}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isOutOfStock
                                            ? Colors.grey
                                            : Warna.teks,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${item.quantity} Stok',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                    color: isOutOfStock
                                        ? Colors.grey
                                        : Warna.hitam,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        );
      }
    }),
  );
}
