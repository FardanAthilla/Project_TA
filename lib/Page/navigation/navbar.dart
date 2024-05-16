import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:project_ta/Page/profile_page/profile_page.dart';
import 'package:project_ta/color.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller =
        PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens() {
      return [
        Placeholder(),
        Placeholder(),
        Placeholder(),
        Placeholder(),
        ProfilePage(),
      ];
    }

    List<PersistentBottomNavBarItem> _navbarItem() {
      return [
        PersistentBottomNavBarItem(
          //1
          icon: SvgPicture.asset(
            'Assets/dashboard.svg',
            width: 24,
            height: 24,
            color: Warna.main,
          ),
          inactiveIcon: SvgPicture.asset(
            'Assets/dashboard.svg',
            width: 24,
            height: 24,
            color: Warna.hitam,
          ),
        ),
        //2
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            'Assets/icon1.svg',
            width: 24,
            height: 24,
            color: Warna.main,
          ),
          inactiveIcon: SvgPicture.asset(
            'Assets/icon1.svg',
            width: 24,
            height: 24,
            color: Warna.hitam,
          ),
        ),
        //3
        PersistentBottomNavBarItem(
          activeColorPrimary: Colors.white,
          icon: SvgPicture.asset(
            'Assets/icon3.svg',
            width: 24,
            height: 24,
            color: Warna.main,
          ),
        ),
        //4
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            'Assets/icon2.svg',
            width: 24,
            height: 24,
            color: Warna.main,
          ),
          inactiveIcon: SvgPicture.asset(
            'Assets/icon2.svg',
            width: 24,
            height: 24,
            color: Warna.hitam,
          ),
        ),
        //5
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            'Assets/icon4.svg',
            width: 24,
            height: 24,
            color: Warna.main,
          ),
          inactiveIcon: SvgPicture.asset(
            'Assets/icon4.svg',
            width: 24,
            height: 24,
            color: Warna.hitam,
          ),
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navbarItem(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style16,
    );
  }
}
