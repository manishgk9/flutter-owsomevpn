import 'package:flutter/material.dart';

class NetworkIpInfo {
  String titleText;
  String subTitleText;
  Icon iconData;
  Color iconColor;

  NetworkIpInfo(
      {required this.titleText,
      required this.subTitleText,
      required this.iconData,
      this.iconColor = Colors.redAccent});
}
