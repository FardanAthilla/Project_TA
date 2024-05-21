import 'package:flutter/material.dart';
import 'package:project_ta/color.dart';

class CustomTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final List<Widget> tabViews;

  const CustomTabBar({
    Key? key,
    required this.tabs,
    required this.tabViews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBar(
                dividerColor: Warna.background,
                labelColor: Warna.background,
                unselectedLabelColor: Warna.hitam,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Warna.main,
                ),
                indicatorPadding: EdgeInsets.symmetric(horizontal: -50),
                tabs: tabs,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: tabViews,
            ),
          ),
        ],
      ),
    );
  }
}