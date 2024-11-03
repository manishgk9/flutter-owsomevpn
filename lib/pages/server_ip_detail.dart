import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owsomevpn/extra_widgets/network_ip_info_widget.dart';
import 'package:owsomevpn/models/ip_info.dart';
import 'package:owsomevpn/models/network_ip_info.dart';
import 'package:owsomevpn/retreivevpns/gate_all_vpn_data.dart';

class ServerIpDetailPage extends StatelessWidget {
  ServerIpDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ipInfo = IpInfo.fromJson({}).obs;
    GateAllVpnData.retriveIPDetails(retriveInformation: ipInfo);

    return Scaffold(
        backgroundColor: const Color(0xFF0A0E21),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 5, bottom: 10),
          child: FloatingActionButton(
            backgroundColor: Colors.purple,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none),
            onPressed: () {
              GateAllVpnData.retriveIPDetails(retriveInformation: ipInfo);
            },
            child: Icon(
              Icons.replay,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 33, 18, 62),
          title: Text(
            "Server Details",
            style:
                TextStyle(color: Colors.grey[200], fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12, top: 4),
          child: Obx(
            () => ListView(
              physics: BouncingScrollPhysics(),
              children: [
                NetworkIpInfoWidget(
                    networkIpInfo: NetworkIpInfo(
                        titleText: "Ip Address",
                        subTitleText: ipInfo.value.countryName.isEmpty
                            ? "Retreiving..."
                            : "${ipInfo.value.query}",
                        iconData: Icon(Icons.gps_fixed))),
                NetworkIpInfoWidget(
                    networkIpInfo: NetworkIpInfo(
                        iconColor: Colors.orange,
                        titleText: "Internet Service Provider",
                        subTitleText: ipInfo.value.countryName.isEmpty
                            ? "Retreiving..."
                            : "${ipInfo.value.internetServiceProvider}",
                        iconData: Icon(Icons.router))),
                NetworkIpInfoWidget(
                    networkIpInfo: NetworkIpInfo(
                        iconColor: Colors.green,
                        titleText: "Ip Location",
                        subTitleText: ipInfo.value.countryName.isEmpty
                            ? "Retreiving..."
                            : "${ipInfo.value.cityName},${ipInfo.value.regionName},${ipInfo.value.countryName}",
                        iconData: Icon(Icons.place))),
                NetworkIpInfoWidget(
                    networkIpInfo: NetworkIpInfo(
                        titleText: "Zip Code",
                        iconColor: Colors.purpleAccent,
                        subTitleText: "${ipInfo.value.zipCode}",
                        iconData: Icon(Icons.my_location_outlined))),
                NetworkIpInfoWidget(
                    networkIpInfo: NetworkIpInfo(
                        iconColor: Colors.blueAccent,
                        titleText: "Timezone",
                        subTitleText: "${ipInfo.value.timeZone}",
                        iconData: Icon(Icons.location_pin))),
              ],
            ),
          ),
        ));
  }
}
