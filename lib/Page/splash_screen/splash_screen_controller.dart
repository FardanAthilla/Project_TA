import 'package:get/get.dart';
import 'package:project_ta/Page/login_page/login_page_view.dart';
import 'package:project_ta/Page/login_page/auth/token.dart';
import 'package:project_ta/Page/sidebar/navigation.dart';

void checkToken() async {
    final token = await getToken();
    if (token != null && token.isNotEmpty) {
      Get.off(Navigation());
    } else {
      Get.off(LoginPage()); 
    }
  }