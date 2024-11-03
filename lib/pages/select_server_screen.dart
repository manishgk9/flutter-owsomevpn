import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owsomevpn/controllers/controller_vpn_location.dart';
import 'package:owsomevpn/controllers/home_controller.dart';
import 'package:owsomevpn/extra_widgets/vpn_loaction_card_widget.dart';
import 'package:owsomevpn/models/model.dart';

class SelectServerIpScreen extends StatelessWidget {
  SelectServerIpScreen({super.key});
  final vpnLocationController = ControllerVpnLocation();
  final homeController = Get.find<HomeController>();
  // final VpnServer vpnserver;
  loadinUIWidget() {
    return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Gathering Vpn Locations...",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            )
          ],
        ));
  }

  noVpnFoundUIWidget() {
    return const Center(
      child: Text(
        "No Vpns Found Try Again..",
        style: TextStyle(
            fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
      ),
    );
  }

  vpnFoundUIWidget() {
    Map<String, List<VpnServer>> groupServersByCountry(
        List<VpnServer> vpnList) {
      Map<String, List<VpnServer>> groupedData = {};
      for (var server in vpnList) {
        String countryKey = server.countryLong; // Use countryLong here
        if (!groupedData.containsKey(countryKey)) {
          groupedData[countryKey] = [];
        }
        groupedData[countryKey]!.add(server);
      }
      return groupedData;
    }

    Map<String, List<VpnServer>> groupedVPNServers =
        groupServersByCountry(vpnLocationController.vpnServerList);
    return ListView(
      children: groupedVPNServers.entries.map((entry) {
        String countryLongName = entry.key;
        List<VpnServer> servers = entry.value;
        int index = groupedVPNServers.keys.toList().indexOf(countryLongName);
        print(index);
        print(index);
        return Padding(
          padding:
              const EdgeInsets.only(left: 10.0, right: 10, top: 4, bottom: 0),
          child: Card(
            color: const Color.fromARGB(255, 15, 20, 45),
            elevation: 4,
            child: ExpansionTile(
              leading: Image.asset(
                  height: 50,
                  width: 65,
                  "assets/country_flags/${servers[0].countryShort.toLowerCase()}.png"),
              title: Text(countryLongName.replaceAll(" Republic of", ""),
                  style: TextStyle(color: Colors.grey[300])),
              children: servers.map((server) {
                return VpnLocationCardWidget(vpnserver: server);
              }).toList(),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (vpnLocationController.vpnServerList.isEmpty) {
      vpnLocationController.retreiveVpnInformation();
    }
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: FloatingActionButton(
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none),
            onPressed: () {
              vpnLocationController.retreiveVpnInformation();
            },
            backgroundColor: Colors.purple,
            child: const Icon(
              Icons.replay,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF0A0E21), // Dark background
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Letest Available Servers ",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[300]),
          ),
          backgroundColor: const Color.fromARGB(255, 33, 18, 62),
          elevation: 0,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onTap: () {
              Get.back();
            },
          ),
        ),
        body: Obx(() => Center(
            child: (vpnLocationController.isLoadingNewLocations.value
                ? loadinUIWidget()
                : vpnLocationController.vpnServerList.isEmpty
                    ? noVpnFoundUIWidget()
                    : vpnFoundUIWidget()))));
  }
}
