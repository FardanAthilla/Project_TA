import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_sparepart.dart';
import 'package:project_ta/Pages/daftar_page/models/Sparepart/model_sparepart.dart';
import 'package:project_ta/Pages/laporan_page/daftar/itemselection.dart';
import 'package:project_ta/Pages/laporan_page/models/model_selection_item.dart';
import 'package:project_ta/Pages/navigation/navbar_view.dart';
import 'package:project_ta/color.dart';

class SparepartTabView extends StatelessWidget {
  final ItemSelectionController itemSelectionController;

  const SparepartTabView({Key? key, required this.itemSelectionController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SparepartController sparepartController = Get.find();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Expanded(
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
                final sparepart = sparepartController.sparePartSelect[index];
                final isSelected = itemSelectionController.isSelected(
                  SelectedItems(
                    category: "spare_part",
                    categoryItemsId: sparepart.categorySparepartId,
                    id: sparepart.sparepartItemsId,
                    item: sparepart.sparepartItemsName,
                    price: sparepart.price,
                    quantity: 1,
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
                                  sparepart.sparepartItemsName,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Warna.hitam,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Sparepart Category',
                                  style: TextStyle(
                                    color: Warna.card,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Rp.${sparepart.price}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Warna.teks,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          sparepart.quantity > 0
                              ? (isSelected
                                  ? IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        editQuantitySparepart(
                                            context, sparepart);
                                      },
                                    )
                                  : IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        showQuantitySparepart(
                                            context, sparepart);
                                      },
                                    ))
                              : const Text('Stok Habis'),
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

  void showQuantitySparepart(BuildContext context, SparepartItem item) {
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
                      categoryItemsId: item.categorySparepartId,
                      category: "spare_part",
                      id: item.sparepartItemsId,
                      item: item.sparepartItemsName,
                      price: item.price,
                      quantity: selectedQuantity,
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

  void editQuantitySparepart(BuildContext context, SparepartItem item) {
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
                      categoryItemsId: item.categorySparepartId,
                      category: "spare_part",
                      id: item.sparepartItemsId,
                      item: item.sparepartItemsName,
                      price: item.price,
                      quantity: selectedQuantity,
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
