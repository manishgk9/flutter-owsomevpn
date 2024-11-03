import 'package:flutter/material.dart';
import 'package:owsomevpn/models/network_ip_info.dart';

// ignore: must_be_immutable
class NetworkIpInfoWidget extends StatelessWidget {
  NetworkIpInfo networkIpInfo;
  NetworkIpInfoWidget({super.key, required this.networkIpInfo});

  @override
  Widget build(BuildContext context) {
    var sizeScreen = MediaQuery.of(context).size;
    return Card(
      color: const Color.fromARGB(255, 15, 20, 45),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: sizeScreen.height * .006),
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        leading: Icon(
          networkIpInfo.iconData.icon,
          size: networkIpInfo.iconData.size ?? 28,
          color: networkIpInfo.iconColor,
        ),
        title: Text(
          networkIpInfo.titleText,
          style: TextStyle(color: Colors.grey[300]),
        ),
        subtitle: Text(
          networkIpInfo.subTitleText,
          style: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
