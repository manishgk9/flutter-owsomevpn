import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:owsomevpn/app_pref/apppreferences.dart';
import 'package:owsomevpn/models/ip_info.dart';
import 'package:owsomevpn/models/model.dart';

class GateAllVpnData {
  static Future<List<VpnServer>> retriveAllVpnServer() async {
    final List<VpnServer> vpnServerList = [];
    try {
      final res =
          await http.get(Uri.parse("https://www.vpngate.net/api/iphone/"));
      final commaSeperatedString = res.body.split("#")[1].replaceAll("*", "");
      List<List<dynamic>> listData =
          CsvToListConverter().convert(commaSeperatedString);
      var header = listData[0];
      for (int count = 1; count < listData.length - 1; count++) {
        Map<String, dynamic> jsonData = {};
        for (int innercount = 0; innercount < header.length; innercount++) {
          jsonData.addAll(
              {header[innercount].toString(): listData[count][innercount]});
        }
        vpnServerList.add(VpnServer.fromJson(jsonData));
      }
    } catch (errorMessege) {
      Get.snackbar('Error Occured!', errorMessege.toString(),
          backgroundColor: Colors.redAccent.withOpacity(.8),
          colorText: Colors.white);
    }
    vpnServerList.shuffle();
    if (vpnServerList.isNotEmpty) AppPreferences.vpnList = vpnServerList;
    return vpnServerList;
  }

  static Future<void> retriveIPDetails(
      {required Rx<IpInfo> retriveInformation}) async {
    try {
      final res = await http.get(Uri.parse("http://ip-api.com/json/"));
      final data = jsonDecode(res.body);
      retriveInformation.value = IpInfo.fromJson(data);
    } catch (errMessege) {
      Get.snackbar('Error Occured!', errMessege.toString(),
          backgroundColor: Colors.redAccent.withOpacity(.8),
          colorText: Colors.white);
    }
  }
}
