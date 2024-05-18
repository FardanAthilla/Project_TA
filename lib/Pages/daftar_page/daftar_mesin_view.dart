import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller.dart';
import 'package:project_ta/Pages/daftar_page/models/model.dart';

class DaftarMesin extends StatelessWidget {
  final StoreController storeController = Get.put(StoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store Items'),
      ),
      body: Column(
        children: [
          Obx(() {
            return DropdownButton<int>(
              hint: Text('Select Category'),
              value: storeController.selectedCategory.value?.categoryMachineId,
              items: [
                DropdownMenuItem<int>(
                  value: 0,
                  child: Text('All Categories'),
                ),
                ...storeController.categories.map((category) {
                  return DropdownMenuItem<int>(
                    value: category.categoryMachineId,
                    child: Text(category.categoryMachineName),
                  );
                }).toList(),
              ],
              onChanged: (value) {
                storeController.selectedCategory.value =
                    storeController.categories.firstWhere((category) => category.categoryMachineId == value, orElse: () => CategoryMachine(categoryMachineId: 0, categoryMachineName: 'All Categories'));
                storeController.filterItemsByCategory(value ?? 0);
              },
            );
          }),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: storeController.filteredItems.length,
                itemBuilder: (context, index) {
                  final item = storeController.filteredItems[index];
                  return ListTile(
                    title: Text(item.storeItemsName),
                    subtitle: Text('Quantity: ${item.quantity}, Price: ${item.price}'),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
