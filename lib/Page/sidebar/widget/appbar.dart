import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_ta/Page/sidebar/navigation.dart';
import 'package:project_ta/color.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int selectedIndex;

  const MyAppBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: buildAppBarTitle(selectedIndex),
      backgroundColor: selectedIndex == 0 ? Warna.main : Warna.background,
      foregroundColor: Warna.white,
      centerTitle: false,
      titleSpacing: 0,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: selectedIndex == 0 ? Warna.white : Warna.teks,
        ),
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
      ),
    );
  }

  Widget buildAppBarTitle(int index) {
    switch (index) {
      case 0:
        return buildAppbarHomePage();
      case 1:
        return buildAppbarTitleSearchMesin();
      case 2:
        return buildAppbarTitleSearchSparepart();
      default:
        return buildAppbarTitle();
    }
  }

  Widget buildAppbarHomePage() {
    return Row(
      children: [
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Text(
            'Nama Kamu',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10.0, left: 10),
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'path_to_your_image',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAppbarTitleSearchMesin() {
    return Row(
      children: [
        SvgPicture.asset(
          'Assets/logo2.svg',
          width: 30,
          height: 30,
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.search, color: Warna.teks),
          onPressed: () {
            // Tambahkan logika pencarian di sini
          },
        ),
      ],
    );
  }

  Widget buildAppbarTitleSearchSparepart() {
    return Row(
      children: [
        SvgPicture.asset(
          'Assets/logo2.svg',
          width: 30,
          height: 30,
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.search, color: Warna.teks),
          onPressed: () {
            // Tambahkan logika pencarian di sini
          },
        ),
      ],
    );
  }

  Widget buildAppbarTitle() {
    return SvgPicture.asset(
      'Assets/logo2.svg',
      width: 30,
      height: 30,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
