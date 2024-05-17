import 'package:get/get.dart';
import 'package:project_ta/Page/login_page/login_page_view.dart';
import 'package:project_ta/Page/navigation/navbar.dart';
import 'package:project_ta/Page/profile_page/profile_binding.dart';
import 'package:project_ta/Page/splash_screen/splash_screen.view.dart';

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
    binding: ProfileBinding()
  ),
];