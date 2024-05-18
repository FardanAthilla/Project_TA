// controllers/store_controller.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:project_ta/Pages/daftar_page/models/Mesin/model.dart';

class StoreController extends GetxController {
  var storeItems = <StoreItem>[].obs;
  var filteredItems = <StoreItem>[].obs;
  var categories = <CategoryMachine>[].obs;
  var selectedCategory = Rxn<CategoryMachine>();

  @override
  void onInit() {
    super.onInit();
    fetchStoreItems();
    fetchCategories();
  }

  void fetchStoreItems() async {
    final response = await http.get(Uri.parse('https://secure-sawfly-certainly.ngrok-free.app/store/items'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['Data'];
      storeItems.value = data.map((item) => StoreItem.fromJson(item)).toList();
      filteredItems.value = storeItems;
    }
  }

  void fetchCategories() async {
    final response = await http.get(Uri.parse('https://secure-sawfly-certainly.ngrok-free.app/category/machine'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['Data'];
      categories.value = data.map((item) => CategoryMachine.fromJson(item)).toList();
    }
  }

  void filterItemsByCategory(int categoryId) {
    if (categoryId == 0) {
      filteredItems.value = storeItems;
    } else {
      filteredItems.value = storeItems.where((item) => item.categoryMachineId == categoryId).toList();
    }
  }
}
