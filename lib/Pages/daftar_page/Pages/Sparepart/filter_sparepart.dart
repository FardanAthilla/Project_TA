import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_sparepart.dart';
import 'package:project_ta/color.dart';

void showFilterModal(BuildContext context, SparepartController sparepartController) {
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
                  children: sparepartController.categories.map((category) {
                    return Column(
                      children: [
                        CheckboxListTile(
                          title: Text(category.categorySparepartName),
                          value: sparepartController.selectedCategories
                              .contains(category.categorySparepartId),
                          activeColor: Warna.main,
                          onChanged: (bool? value) {
                            if (value == true) {
                              sparepartController.selectedCategories
                                  .add(category.categorySparepartId);
                            } else {
                              sparepartController.selectedCategories
                                  .remove(category.categorySparepartId);
                            }
                            sparepartController.searchItems(sparepartController.searchController.text);
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
                        sparepartController.clearSelectedCategories();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Warna.danger,
                        backgroundColor: Warna.background,
                        side: BorderSide(color: Warna.danger),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text('Bersihkan'),
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
