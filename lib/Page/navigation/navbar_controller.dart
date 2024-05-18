import 'package:get/get.dart';

class NavbarController extends GetxController {
  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  void resetIndex() {
    selectedIndex.value = 0;
  }
}
