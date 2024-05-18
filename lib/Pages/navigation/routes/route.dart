import 'package:get/get.dart';
import 'package:project_ta/Pages/login_page/login_page_view.dart';
import 'package:project_ta/Pages/navigation/navbar_view.dart';
import 'package:project_ta/Pages/splash_screen/splash_screen.view.dart';

List<GetPage> routes = [
  GetPage(
    name: '/',
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