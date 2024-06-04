import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/color.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_mesin.dart';

void showFilterModal(BuildContext context, StoreController storeController) {
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
                            storeController.searchItems(storeController.searchController.text);
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
