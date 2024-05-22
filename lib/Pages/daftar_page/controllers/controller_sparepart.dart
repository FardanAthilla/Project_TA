import 'package:flutter/material.dart';
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
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchStoreItems();
    fetchCategories();
    searchItems("");
  }

  void fetchStoreItems() async {
    isLoading(true);
    final response = await http
        .get(Uri.parse('https://rdo-app-o955y.ondigitalocean.app/spare/part'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['Data'];
      storeItems.value =
          data.map((item) => SparepartItem.fromJson(item)).toList();
    }
    isLoading(false);
  }

  void fetchCategories() async {
    isLoading(true);
    final response = await http.get(Uri.parse(
        'https://rdo-app-o955y.ondigitalocean.app/category/spare/part'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['Data'];
      categories.value =
          data.map((item) => CategorySparepart.fromJson(item)).toList();
    }
    isLoading(false);
  }

  void clearSelectedCategories() {
    selectedCategories.clear();
  }

  void searchItems(String query) async {
    final response = await http.get(Uri.parse(
        'https://rdo-app-o955y.ondigitalocean.app/search/sparePart?name=$query&categories=${selectedCategories.join(',')}'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      filteredItems.value =
          data.map((item) => SparepartItem.fromJson(item)).toList();
    } else {
      filteredItems.value = [];
    }
  }
}
