import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_mesin.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_sparepart.dart';
import 'package:project_ta/Pages/daftar_page/models/Mesin/model_mesin.dart';
import 'package:project_ta/Pages/daftar_page/models/Sparepart/model_sparepart.dart';
import 'package:project_ta/Pages/laporan_page/Mesin/itemselection.dart';
import 'package:project_ta/Pages/laporan_page/models/model_selection_item.dart';
import 'package:project_ta/Pages/laporan_page/widget/custom_tabbar.dart';

class DaftarMesinPage extends StatelessWidget {
  final ItemSelectionController itemSelectionController;

  DaftarMesinPage({required this.itemSelectionController});

  @override
  Widget build(BuildContext context) {
    final StoreController storeController = Get.find();
    final SparepartController sparepartController = Get.find();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pilih Barang'),
        ),
        body: CustomTabBar(
          tabs: const [
            Tab(text: 'ㅤMesinㅤ'),
            Tab(text: 'Sparepart'),
          ],
          tabViews: [
            Obx(() {
              return ListView.builder(
                itemCount: storeController.filteredItems.length,
                itemBuilder: (context, index) {
                  final item = storeController.filteredItems[index];
      final isSelected = itemSelectionController.isSelected(SelectedItems(
        categoryItemsId: item.categoryMachineId,
        category: "mesin",
                              price: item.price,
        id: item.storeItemsId,
        item: item.storeItemsName,
        quantity: 1,
      ));
                  return ListTile(
                    title: Text(item.storeItemsName),
                    subtitle: Text('Rp.${item.price}'),
                    trailing: isSelected
                        ? IconButton(
                            icon: Icon(Icons.remove_circle),
                            onPressed: () {
                              itemSelectionController.deselectItem(SelectedItems(
                                categoryItemsId: item.categoryMachineId,
                                category: "mesin",
                    id: item.storeItemsId,
                    item: item.storeItemsName,
                                          price: item.price,

                    quantity: 1,
                  ));
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              showQuantityStore(context, item);
                            },
                          ),
                  );
                },
              );
            }),
            Obx(() {
              return ListView.builder(
                itemCount: sparepartController.sparePartSelect.length,
                itemBuilder: (context, index) {
                  final item = sparepartController.sparePartSelect[index];
                        final isSelected = itemSelectionController.isSelected(SelectedItems(
                          category: "spare_part",
                          categoryItemsId: item.categorySparepartId,
        id: item.sparepartItemsId,
        item: item.sparepartItemsName,
                              price: item.price,

        quantity: 1,
      ));
                  return ListTile(
                    title: Text(item.sparepartItemsName),
                    subtitle: Text('Rp.${item.price}'),
                    trailing: isSelected
                        ? IconButton(
                            icon: Icon(Icons.remove_circle),
                            onPressed: () {
itemSelectionController.deselectItem(SelectedItems(
                        price: item.price,
                        category: "spare_part",
                        categoryItemsId: item.categorySparepartId,
                    id: item.sparepartItemsId,
                    item: item.sparepartItemsName,
                    quantity: 1,
                  ));                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              showQuantitySparepart(context, item);
                            },
                          ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  void showQuantityStore(BuildContext context, StoreItem item) {
    final int stock = item.quantity;
    int selectedQuantity = 1;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text('Pilih Jumlah'),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
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
                    style: TextStyle(fontSize: 24.0),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
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
              actions: [
                TextButton(
                  onPressed: () {
                    var items = SelectedItems(
                      categoryItemsId: item.categoryMachineId,
                      category: "mesin",
                      id: item.storeItemsId,
                      item: item.storeItemsName,
                      quantity: selectedQuantity,
                      price: item.price
                    );
                    itemSelectionController.selectItem(items);
                    Get.back();
                  },
                  child: Text('Tambah'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showQuantitySparepart(BuildContext context, SparepartItem item) {
    final int stock = item.quantity;
    int selectedQuantity = 1;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text('Pilih Jumlah'),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
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
                    style: TextStyle(fontSize: 24.0),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
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
              actions: [
                TextButton(
                  onPressed: () {
                    var items = SelectedItems(
                      categoryItemsId: item.categorySparepartId,
                      category: "spare_part",
                      id: item.sparepartItemsId,
                      item : item.sparepartItemsName,
                      price: item.price,
                      quantity: selectedQuantity
                    );
                    itemSelectionController.selectItem(items);
                    Get.back();
                  },
                  child: Text('Tambah'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
