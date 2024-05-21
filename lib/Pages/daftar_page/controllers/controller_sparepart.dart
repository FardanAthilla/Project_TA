import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_ta/Pages/daftar_page/models/Mesin/model_sparepart.dart';
import 'dart:convert';

class SparepartController extends GetxController {
  var storeItems = <SparepartItem>[].obs;
  var filteredItems = <SparepartItem>[].obs;
  var categories = <CategorySparepart>[].obs;
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
        .get(Uri.parse('https://rdo-app-o955y.ondigitalocean.app/spare/part'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['Data'];
      storeItems.value = data.map((item) => SparepartItem.fromJson(item)).toList();
      filterItemsByCategories();
    }
    isLoading(false);
  }

  void fetchCategories() async {
    isLoading(true);
    final response = await http.get(
        Uri.parse('https://rdo-app-o955y.ondigitalocean.app/category/spare/part'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['Data'];
      categories.value =
          data.map((item) => CategorySparepart.fromJson(item)).toList();
    }
    isLoading(false);
  }

  void filterItemsByCategories() {
    if (selectedCategories.isEmpty) {
      filteredItems.value = storeItems;
    } else {
      filteredItems.value = storeItems
          .where((item) => selectedCategories.contains(item.categorySparepartId))
          .toList();
    }
  }

  void clearSelectedCategories() {
    selectedCategories.clear();
    filterItemsByCategories();
  }
}
