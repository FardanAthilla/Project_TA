import 'package:get/get.dart';
import 'package:project_ta/Pages/laporan_page/models/model_selection_item.dart';

class ItemSelectionController extends GetxController {
  var selectedItems = <SelectedItems>[].obs;
  var selectedQuantities = <int, int>{}.obs;
  var showBottomBar = false.obs;

  bool isSelected(SelectedItems item) {
    return selectedItems.any((selected) =>
        selected.item == item.item &&
        selected.category == item.category &&
        selected.categoryItemsId == item.categoryItemsId);
  }

  void updateQuantity(int itemId, int quantity) {
    selectedQuantities[itemId] = quantity;
  }

  void removeQuantity(int itemId) {
    selectedQuantities.remove(itemId);
  }

  void selectItem(SelectedItems item) {
    selectedItems.add(item);
  }

  void deselectItem(SelectedItems item) {
    selectedItems.removeWhere((selected) =>
        selected.item == item.item &&
        selected.category == item.category &&
        selected.categoryItemsId == item.categoryItemsId);
  }

  void editItem(SelectedItems item) {
    final index = selectedItems.indexWhere((selected) =>
        selected.item == item.item &&
        selected.category == item.category &&
        selected.categoryItemsId == item.categoryItemsId);
    if (index != -1) {
      selectedItems[index] = item;
    }
  }

  void clearSelections() {
    selectedItems.clear();
    selectedQuantities.clear();
  }

  void resetAllQuantities() {
    selectedQuantities.clear();
    selectedItems.clear();
    showBottomBar.value = false;
  }

  void clearSingleItem(int itemId) {
    selectedQuantities.remove(itemId);
    selectedItems.removeWhere((item) => item.id == itemId);
    if (selectedQuantities.isEmpty) {
      showBottomBar.value = false;
    }
  }
}
