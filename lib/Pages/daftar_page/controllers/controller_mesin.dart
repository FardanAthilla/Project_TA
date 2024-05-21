import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project_ta/Pages/daftar_page/models/Mesin/model.dart';

class StoreController extends GetxController {
  var storeItems = <StoreItem>[].obs;
  var filteredItems = <StoreItem>[].obs;
  var categories = <CategoryMachine>[].obs;
  var selectedCategories = <int>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStoreItems();
    fetchCategories();
  }

  void fetchStoreItems() async {
    isLoading(true);
    final response = await http
        .get(Uri.parse('https://rdo-app-o955y.ondigitalocean.app/store/items'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['Data'];
      storeItems.value = data.map((item) => StoreItem.fromJson(item)).toList();
      filterItemsByCategories();
    }
    isLoading(false);
  }

  void fetchCategories() async {
    isLoading(true);
    final response = await http.get(
        Uri.parse('https://rdo-app-o955y.ondigitalocean.app/category/machine'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['Data'];
      categories.value =
          data.map((item) => CategoryMachine.fromJson(item)).toList();
    }
    isLoading(false);
  }

  void filterItemsByCategories() {
    if (selectedCategories.isEmpty) {
      filteredItems.value = storeItems;
    } else {
      filteredItems.value = storeItems
          .where((item) => selectedCategories.contains(item.categoryMachineId))
          .toList();
    }
  }

  void clearSelectedCategories() {
    selectedCategories.clear();
    filterItemsByCategories();
  }
}
