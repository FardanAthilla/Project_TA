import 'package:get/get.dart';
import 'package:project_ta/Pages/laporan_page/models/model_selection_item.dart';

class ItemSelectionController extends GetxController {
  var selectedItems = <SelectedItems>[].obs; 
  var selectedQuantities = <int, int>{}.obs;
  var showBottomBar = false.obs;

  var selectedItemsSparepart = <SelectedItems>[].obs;
  var selectedQuantitiesSparepart = <int, int>{}.obs;
  var showBottomBarSparepart = false.obs;

  var selectedItemsSparepartService = <SelectedItems>[].obs;
  var selectedQuantitiesSparepartService = <int, int>{}.obs;
  var showBottomBarSparepartService = false.obs;

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

  void updateQuantitySparepartService(int item, int quantity) {
    selectedQuantitiesSparepartService[item] = quantity;
  }

  void removeQuantitySparepartService(int item) {
    selectedQuantitiesSparepartService.remove(item);
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
    selectedItems.removeWhere((selected) => selected.id == itemId);
    selectedQuantities.remove(itemId);
    selectedQuantitiesSparepart.remove(itemId);
    if (selectedQuantities.isEmpty) {
      showBottomBar.value = false;
    }
    if (selectedQuantitiesSparepart.isEmpty) {
      showBottomBarSparepart.value = false;
    }
  }

  void selectItemSparepartService(SelectedItems item) {
    int index = selectedItemsSparepartService.indexWhere((selected) =>
        selected.item == item.item &&
        selected.category == item.category &&
        selected.categoryItemsId == item.categoryItemsId);
    if (index != -1) {
      selectedItemsSparepartService[index] = item;
    } else {
      selectedItemsSparepartService.add(item);
    }
  }

  void deselectItemSparepartService(SelectedItems item, int itemId) {
    selectedItemsSparepartService.removeWhere((selected) => selected.id == itemId);
    selectedQuantitiesSparepartService.remove(itemId);
    if (selectedQuantitiesSparepartService.isEmpty) {
      showBottomBarSparepartService.value = false;
    }
  }

  void resetAllQuantities() {
    selectedQuantities.clear();
    selectedQuantitiesSparepart.clear();
    selectedItems.clear();
    selectedQuantitiesSparepartService.clear();
    showBottomBar.value = false;
    showBottomBarSparepart.value = false;
    showBottomBarSparepartService.value = false;
  }
}
