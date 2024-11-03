// ignore: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owsomevpn/controllers/home_controller.dart';
import 'package:owsomevpn/pages/proxypage.dart';
import 'package:owsomevpn/pages/server_ip_detail.dart';
import 'package:owsomevpn/pages/sharepage.dart';
import 'package:owsomevpn/pages/vpn_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  BottomController controller = Get.put(BottomController());
  List pages = [
    VpnHomePage(),
    ServerIpDetailPage(),
    ProxySettingsPage(),
    SharePage()
  ];
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    Widget BottomBarWidget() {
      return BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: controller.onChangeNav,
        selectedItemColor: Color.fromARGB(255, 133, 157, 230),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        enableFeedback: false, // Disable haptic feedback
        mouseCursor: SystemMouseCursors.none, // Disable hover cursor effect

        showUnselectedLabels: true,
        backgroundColor: const Color(0xFF0A0E21).withOpacity(0.9),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.location_fill), label: 'Server'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.shield_fill), label: 'Proxy'),
          BottomNavigationBarItem(icon: Icon(Icons.share), label: 'Share'),
        ],
      );
    }

    // ignore: non_constant_identifier_names
    Widget ChooseScreenWidget() {
      return pages[controller.selectedIndex.value];
    }

    return Scaffold(
        body: Obx(() => ChooseScreenWidget()),
        bottomNavigationBar: Obx(() => BottomBarWidget()));
  }
}
