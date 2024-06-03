import 'package:get/get.dart';
import 'package:project_ta/Pages/laporan_page/models/model_selection_item.dart';

class ItemSelectionController extends GetxController {
  var selectedItems = <SelectedItems>[].obs;
  var selectedQuantities = <int, int>{}.obs;
  var selectedItemsSparepart = <SelectedItems>[].obs;
  var selectedQuantitiesSparepart = <int, int>{}.obs;
  var showBottomBar = false.obs;
  var showBottomBarSparepart = false.obs;

  void updateQuantityMachine(int itemId, int quantity) {
    selectedQuantities[itemId] = quantity;
  }

  void removeQuantityMachine(int itemId) {
    selectedQuantities.remove(itemId);
  }

  void updateQuantitySparepart(int item, int quantity) {
    selectedQuantitiesSparepart[item] = quantity;
  }

  void removeQuantitySparepart(int item) {
    selectedQuantitiesSparepart.remove(item);
  }

  void selectItem(SelectedItems item) {
    int index = selectedItems.indexWhere((selected) =>
        selected.item == item.item &&
        selected.category == item.category &&
        selected.categoryItemsId == item.categoryItemsId);
    if (index != -1) {
      selectedItems[index] = item;
    } else {
      selectedItems.add(item);
    }
  }

void deselectItem(SelectedItems item, int itemId) {
  // Hapus item dari selectedItems berdasarkan id
  selectedItems.removeWhere((selected) => selected.id == itemId);
  
  // Hapus kuantitas item dari selectedQuantities dan selectedQuantitiesSparepart
  selectedQuantities.remove(itemId);
  selectedQuantitiesSparepart.remove(itemId);

  // Periksa apakah ada item yang tersisa, jika tidak, sembunyikan BottomBar
  if (selectedQuantities.isEmpty) {
    showBottomBar.value = false;
  }
}


  void resetAllQuantities() {
    selectedQuantities.clear();
    selectedQuantitiesSparepart.clear();
    selectedItems.clear();
    showBottomBar.value = false;
  }
}
