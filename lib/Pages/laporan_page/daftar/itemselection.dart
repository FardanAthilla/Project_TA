import 'package:get/get.dart';
import 'package:project_ta/Pages/laporan_page/models/model_selection_item.dart';

class ItemSelectionController extends GetxController {
  var selectedItems = <SelectedItems>[].obs;

  bool isSelected(SelectedItems item) {
    return selectedItems.any((selected) =>
        selected.item == item.item &&
        selected.category == item.category &&
        selected.categoryItemsId == item.categoryItemsId);
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
}
