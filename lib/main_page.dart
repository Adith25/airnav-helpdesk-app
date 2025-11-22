import 'package:airnav_helpdesk/modules/faq/faq_page.dart';
import 'package:airnav_helpdesk/modules/ticket/add_ticket_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'main_controller.dart';
import 'modules/dashboard/dashboard_page.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  List<Widget> _screens() => [DashboardPage(), AddTicketPage(), FaqPage()];

  List<PersistentBottomNavBarItem> _items() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.dashboard_outlined),
      title: 'Dashboard',
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.grey.shade400,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.add_circle_outline),
      title: 'Submit Ticket',
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.grey.shade400,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.help_outline),
      title: 'FAQ',
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.grey.shade400,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller.tabController,
      screens: _screens(),
      items: _items(),
      navBarStyle: NavBarStyle.style3,
      backgroundColor: Colors.white,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0),
        colorBehindNavBar: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      stateManagement: false,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
    );
  }
}
