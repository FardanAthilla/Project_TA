import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller.dart';
import 'package:project_ta/Pages/daftar_page/models/Mesin/model.dart';
import 'package:project_ta/color.dart';
import 'package:shimmer/shimmer.dart';

class DaftarMesin extends StatelessWidget {
  final StoreController storeController = Get.put(StoreController());

  Future<void> _refreshItems() async {
    storeController.fetchStoreItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            surfaceTintColor: Warna.background,
            title: SvgPicture.asset(
              'Assets/logo2.svg',
              width: 30,
              height: 30,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  _buildCategoryButton(
                    context: context,
                    label: 'Mesin',
                    isSelected: true,
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  _buildCategoryButton(
                    context: context,
                    label: 'Sparepart',
                    isSelected: false,
                    onTap: () {
                      Get.to(() => Placeholder()); 
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const Expanded(
                    child: SizedBox(
                      height: 48,
                      child: TextField(
                        decoration: InputDecoration(
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
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      _showFilterModal(context);
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
          ),
          SliverToBoxAdapter(
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kategori Mesin',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Obx(() {
            if (storeController.isLoading.value) {
              return SliverFillRemaining(
                child: _buildShimmer(),
              );
            } else {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = storeController.filteredItems[index];
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
                                      item.storeItemsName,
                                      style: TextStyle(
                                        fontSize: 15,
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
                  childCount: storeController.filteredItems.length,
                ),
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _buildCategoryButton({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(54),
          border: Border.all(color: Colors.blue),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isSelected ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 400,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: storeController.categories.map((category) {
                      return Column(
                        children: [
                          CheckboxListTile(
                            title: Text(category.categoryMachineName),
                            value: storeController.selectedCategories
                                .contains(category.categoryMachineId),
                            activeColor: Warna.main,
                            onChanged: (bool? value) {
                              if (value == true) {
                                storeController.selectedCategories
                                    .add(category.categoryMachineId);
                              } else {
                                storeController.selectedCategories
                                    .remove(category.categoryMachineId);
                              }
                              storeController.filterItemsByCategories();
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          storeController.clearSelectedCategories();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Warna.danger,
                          backgroundColor: Warna.background,
                          side: BorderSide(color: Warna.danger),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Hapus'),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Warna.main,
                          foregroundColor: Warna.background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Pasang'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        );
      },
    );
  }

  Widget _buildShimmer() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refreshItems,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 15,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 12,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 12,
                                width: 100,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
