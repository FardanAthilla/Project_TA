import 'package:get/get.dart';
import 'package:project_ta/Page/login_page/login_page_view.dart';
import 'package:project_ta/Page/login_page/auth/token.dart';
import 'package:project_ta/Page/navigation/navbar.dart';

void checkToken() async {
    final token = await getToken();
    if (token != null && token.isNotEmpty) {
      Get.off(Navbar());
    } else {
      Get.off(LoginPage()); 
    }
  }