import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project_ta/Pages/daftar_page/models/Mesin/model_mesin.dart';

class StoreController extends GetxController {
  var storeItems = <StoreItem>[].obs;
  var filteredItems = <StoreItem>[].obs;
  var categories = <CategoryMachine>[].obs;
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
        .get(Uri.parse('https://rdo-app-o955y.ondigitalocean.app/store/items'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['Data'];
      storeItems.value = data.map((item) => StoreItem.fromJson(item)).toList();
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

  void clearSelectedCategories() {
    selectedCategories.clear();
    searchItems("");
  }

  void searchItems(String query) async {
    final response = await http.get(Uri.parse(
        'https://rdo-app-o955y.ondigitalocean.app/search/machine?name=$query&categories=${selectedCategories.join(',')}'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      filteredItems.value =
          data.map((item) => StoreItem.fromJson(item)).toList();
    } else {
      filteredItems.value = [];
    }
  }
}
