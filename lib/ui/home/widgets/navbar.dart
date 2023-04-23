import 'package:flutter/material.dart';
import '../../utils/styles.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 10,
        child: TabBarView(controller: tabController, children: [Container()]));
  }
}

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({Key? key, required this.controller, required this.tabs})
      : super(key: key);

  final TabController controller;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TabBar(
          labelColor: Styles.obscureGreen,
          indicatorColor: Styles.obscureGreen,
          controller: controller,
          tabs: tabs),
    );
  }
}

class CustomTab extends StatelessWidget {
  const CustomTab({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        style: const TextStyle(fontSize: 17),
      ),
    );
  }
}
