import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:owsomevpn/models/model.dart';

class AppPreferences {
  static late Box boxOfData; // Made it static for global access

  // Initialize Hive
  static Future<void> initHive() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    boxOfData = await Hive.openBox('data');
  }

  // Getter for VPN server object
  static VpnServer get vpnServerObj =>
      VpnServer.fromJson(jsonDecode(boxOfData.get('vpn') ?? '{}'));

  // Setter for VPN server object
  static set vpnServerObj(VpnServer value) =>
      boxOfData.put('vpn', jsonEncode(value));

  static bool get isIntrowed =>
      boxOfData.get('isIntrowed', defaultValue: false);
  static set isIntrowed(bool value) => boxOfData.put('isIntrowed', value);

  // Getter for VPN list
  static List<VpnServer> get vpnList {
    List<VpnServer> tempVpnList = [];
    final vpnData = jsonDecode(boxOfData.get('vpnList') ?? '[]');

    for (var data in vpnData) {
      tempVpnList.add(VpnServer.fromJson(data));
    }
    return tempVpnList;
  }

  // Setter for VPN list
  static set vpnList(List<VpnServer> valueList) =>
      boxOfData.put('vpnList', jsonEncode(valueList));
}
