import 'package:get/get.dart';
import 'package:project_ta/Pages/profile_page/profile_controller.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
