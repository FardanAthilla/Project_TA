import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_sparepart.dart';
import 'package:project_ta/Pages/daftar_page/models/Sparepart/model_sparepart.dart';
import 'package:project_ta/Pages/daftar_page/Pages/Sparepart/filter_sparepart.dart';
import 'package:project_ta/color.dart';

Widget buildSparepartList(
    BuildContext context, SparepartController sparepartController) {
  final FocusNode searchFocusNode = FocusNode();

  Future<void> refreshItems() async {
    sparepartController.fetchStoreItems();
  }

  return GestureDetector(
    onTap: () {
      searchFocusNode.unfocus();
    },
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: TextField(
                    controller: sparepartController.searchController,
                    focusNode: searchFocusNode,
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
                      sparepartController.searchItems(query);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  showFilterModal(context, sparepartController);
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
              'Daftar Sparepart',
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
              if (sparepartController.filteredItems.isEmpty) {
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
                itemCount: sparepartController.filteredItems.length,
                itemBuilder: (context, index) {
                  final item = sparepartController.filteredItems[index];
                  final category = sparepartController.categories.firstWhere(
                    (cat) =>
                        cat.categorySparepartId == item.categorySparepartId,
                    orElse: () => CategorySparepart(
                      categorySparepartId: 0,
                      categorySparepartName: 'Unknown Category',
                    ),
                  );
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12.0,
                          right: 12.0,
                          top: 8.0,
                          bottom: 8.0,
                        ),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.sparepartItemsName,
                                    style: TextStyle(
                                      fontSize: 15,
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${item.quantity} Stok',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  color: Warna.hitam,
                                ),
                              ),
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
        ),
      ],
    ),
  );
}
