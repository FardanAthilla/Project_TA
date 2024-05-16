import 'package:get/get.dart';
import 'package:project_ta/Page/login_page/login_page_view.dart';
import 'package:project_ta/Page/navigation/navbar.dart';
import 'package:project_ta/Page/splash_screen/splash_screen.view.dart';

List<GetPage> routes = [
  GetPage(
    name: '/splash',
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: '/login',
    page: () => LoginPage(),
  ),
  GetPage(
    name: '/navbar',
    page: () => Navbar(),
  ),
];