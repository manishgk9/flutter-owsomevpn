import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owsomevpn/app_pref/apppreferences.dart';
import 'package:owsomevpn/models/model.dart';
import 'package:owsomevpn/models/vpn_configuration.dart';
import 'package:owsomevpn/vpn_engine/vpn_engine.dart';

class HomeController extends GetxController {
  final Rx<VpnServer> vpnserver = AppPreferences.vpnServerObj.obs;
  final vpnConnectionState = VpnEngine.vpnDisconnectedNow.obs;

  // Method to connect to VPN
  void connectToVpnNow() async {
    if (vpnserver.value.base64openVpnConfigData.isEmpty) {
      Get.snackbar(
          backgroundColor: Colors.pink,
          colorText: Colors.grey[200],
          'Country / Location',
          'Please Select Country / Location First');
      return;
    }

    // Disconnect the VPN if already connected
    if (vpnConnectionState.value == VpnEngine.vpnDisconnectedNow) {
      try {
        final vpnConfigData =
            base64Decode(vpnserver.value.base64openVpnConfigData);
        final configuration = Utf8Decoder().convert(vpnConfigData);

        final vpnConfiguration = VpnConfiguration(
          username: 'vpn',
          password: 'vpn',
          config: configuration,
          countryName: vpnserver.value.countryLong,
        );
        await VpnEngine.startVpnNow(vpnConfiguration);
      } catch (e) {
        Get.snackbar(
          'VPN Connection Error',
          'Failed to connect Check Internet',
          backgroundColor: Colors.pink,
          colorText: Colors.grey[200],
        );
      }
    } else {
      try {
        await VpnEngine.stopVpnNow();
      } catch (e) {
        Get.snackbar(
          'VPN Disconnection Error',
          'Failed to disconnect something not good',
          backgroundColor: Colors.pink,
          colorText: Colors.grey[200],
        );
      }
    }
  }

  // Dynamic button color based on VPN state
  Color get getRoundVpnButtonColor {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnectedNow:
        return Colors.blue;
      case VpnEngine.vpnConnectedNow:
        return Colors.green;
      case VpnEngine.vpnConnectingNow:
      default:
        return Colors.orange;
    }
  }

  // Dynamic button text based on VPN state
  String get getRoundVpnButtonText {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnectedNow:
        return "Let's Connect";
      case VpnEngine.vpnConnectedNow:
        return "Disconnect";
      case VpnEngine.vpnConnectingNow:
        return "Connecting";
      default:
        return "Connecting";
    }
  }
}

class BottomController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void onChangeNav(int value) {
    selectedIndex.value = value;
  }
}

class ProxyController extends GetxController {
  var proxyAddress = ''.obs;
  var port = ''.obs;
  var username = ''.obs;
  var password = ''.obs;
  var useAuth = false.obs;

  void toggleAuth(bool value) {
    useAuth.value = value;
  }
}
