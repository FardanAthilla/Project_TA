import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_mesin.dart';
import 'package:project_ta/Pages/daftar_page/models/Mesin/model_mesin.dart';
import 'package:project_ta/Pages/laporan_page/daftar/itemselection.dart';
import 'package:project_ta/Pages/laporan_page/models/model_selection_item.dart';
import 'package:project_ta/Pages/navigation/navbar_view.dart';
import 'package:project_ta/color.dart';

class MesinTabView extends StatelessWidget {
  final ItemSelectionController itemSelectionController;

  const MesinTabView({Key? key, required this.itemSelectionController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StoreController storeController = Get.find();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Expanded(
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
                final isSelected = itemSelectionController.isSelected(
                  SelectedItems(
                    categoryItemsId: item.categoryMachineId,
                    category: "mesin",
                    price: item.price,
                    id: item.storeItemsId,
                    item: item.storeItemsName,
                    quantity: 1,
                  ),
                );
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
                              ? (isSelected
                                  ? IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        editQuantityStore(context, item);
                                      },
                                    )
                                  : IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        showQuantityStore(context, item);
                                      },
                                    ))
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
    );
  }

  void showQuantityStore(BuildContext context, StoreItem item) {
    if (item.quantity == 0) return;

    final int stock = item.quantity;
    int selectedQuantity = 1;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                'Pilih Jumlah',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black87,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Stok tersedia: $stock',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Warna.danger),
                        onPressed: () {
                          if (selectedQuantity > 1) {
                            setState(() {
                              selectedQuantity--;
                            });
                          }
                        },
                      ),
                      Text(
                        selectedQuantity.toString(),
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Warna.main),
                        onPressed: () {
                          if (selectedQuantity < stock) {
                            setState(() {
                              selectedQuantity++;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    var items = SelectedItems(
                      categoryItemsId: item.categoryMachineId,
                      category: "mesin",
                      id: item.storeItemsId,
                      item: item.storeItemsName,
                      quantity: selectedQuantity,
                      price: item.price,
                    );
                    itemSelectionController.selectItem(items);
                    Get.offAll(Navbar());
                  },
                  child: Text(
                    'Tambah',
                    style: TextStyle(
                      color: Warna.main,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void editQuantityStore(BuildContext context, StoreItem item) {
    if (item.quantity == 0) return;

    final int stock = item.quantity;
    int selectedQuantity = 1;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                'Pilih Jumlah',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black87,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Stok tersedia: $stock',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Warna.danger),
                        onPressed: () {
                          if (selectedQuantity > 1) {
                            setState(() {
                              selectedQuantity--;
                            });
                          }
                        },
                      ),
                      Text(
                        selectedQuantity.toString(),
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Warna.main),
                        onPressed: () {
                          if (selectedQuantity < stock) {
                            setState(() {
                              selectedQuantity++;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    var items = SelectedItems(
                      categoryItemsId: item.categoryMachineId,
                      category: "mesin",
                      id: item.storeItemsId,
                      item: item.storeItemsName,
                      quantity: selectedQuantity,
                      price: item.price,
                    );
                    itemSelectionController.editItem(items);
                    Get.offAll(Navbar());
                  },
                  child: Text(
                    'Ubah',
                    style: TextStyle(
                      color: Warna.main,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
