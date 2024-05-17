import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_ta/Page/navigation/navbar_controller.dart';
import 'package:project_ta/Page/profile_page/profile_page.dart';
import 'package:project_ta/color.dart';

class Navbar extends StatelessWidget {
  final NavbarController controller = Get.put(NavbarController());

  Navbar({Key? key}) : super(key: key);

  List<Widget> _buildScreens() {
    return [
      Placeholder(),
      Placeholder(),
      Placeholder(),
      ProfilePage(),
    ];
  }

  List<BottomNavigationBarItem> _navbarItems() {
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'Assets/icon1.svg',
          width: 22,
          height: 22,
          color: Warna.teks,
        ),
        activeIcon: SvgPicture.asset(
          'Assets/icon1.svg',
          width: 22,
          height: 22,
          color: Warna.main,
        ),
        label: 'Stock',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'Assets/icon5.svg',
          width: 22,
          height: 22,
          color: Warna.teks,
        ),
        activeIcon: SvgPicture.asset(
          'Assets/icon5.svg',
          width: 22,
          height: 22,
          color: Warna.main,
        ),
        label: 'Lapor',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'Assets/icon2.svg',
          width: 24,
          height: 24,
          color: Warna.teks
        ),
        activeIcon: SvgPicture.asset(
          'Assets/icon2.svg',
          width: 24,
          height: 24,
          color: Warna.main,
        ),
        label: 'Rekap',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'Assets/icon4.svg',
          width: 22,
          height: 22,
          color: Warna.teks
        ),
        activeIcon: SvgPicture.asset(
          'Assets/icon4.svg',
          width: 22,
          height: 22,
          color: Warna.main,
        ),
        label: 'Profile',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() => IndexedStack(
              index: controller.selectedIndex.value,
              children: _buildScreens(),
            )),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, -1),
              ),
            ],
          ),
          child: Obx(() => BottomNavigationBar(
                items: _navbarItems(),
                currentIndex: controller.selectedIndex.value,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.black,
                onTap: controller.onItemTapped,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
              )),
        ),
      ),
    );
  }
}
