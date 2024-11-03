import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owsomevpn/app_pref/apppreferences.dart';
import 'package:owsomevpn/controllers/home_controller.dart';
import 'package:owsomevpn/models/model.dart';
import 'package:owsomevpn/vpn_engine/vpn_engine.dart';

class VpnLocationCardWidget extends StatelessWidget {
  final VpnServer vpnserver;

  VpnLocationCardWidget({super.key, required this.vpnserver});

  @override
  Widget build(BuildContext context) {
    // final sizeScreen = MediaQuery.of(context).size;
    final homeController = Get.find<HomeController>();
    String getNetworkLevel(int ping) {
      if (ping >= 1 && ping <= 10) {
        return 'bar_level_4.png';
      } else if (ping >= 11 && ping <= 35) {
        return 'bar_level_3.png';
      } else if (ping >= 36 && ping <= 100) {
        return 'bar_level_2.png';
      } else {
        return 'bar_level_1.png';
      }
    }

    return GestureDetector(
      onTap: () {
        // Update the selected VPN server
        homeController.vpnserver.value = vpnserver;
        AppPreferences.vpnServerObj = vpnserver;
        Get.back();

        // Check if the VPN is currently connected
        if (homeController.vpnConnectionState.value ==
            VpnEngine.vpnConnectedNow) {
          // If connected, disconnect and then reconnect after a delay
          VpnEngine.stopVpnNow();
          Future.delayed(Duration(seconds: 3), () {
            homeController.connectToVpnNow(); // Reconnect to the new server
          });
        } else {
          // If not connected, directly connect to the new server
          homeController.connectToVpnNow();
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 2),
        child: Card(
          color: const Color.fromARGB(255, 15, 20, 45),
          elevation: 4,
          child: ListTile(
            shape: OutlineInputBorder(borderSide: BorderSide.none),
            title: Text(
              "${vpnserver.countryLong}",
              style: TextStyle(color: Colors.grey[300]),
            ),
            subtitle: Text("${vpnserver.ip}",
                style: TextStyle(color: Colors.grey[500])),
            trailing: Image.asset(
              "assets/network_icon/${getNetworkLevel(vpnserver.ping)}",
              height: 30,
              width: 18,
            ),
          ),
        ),
      ),
    );
  }
}
