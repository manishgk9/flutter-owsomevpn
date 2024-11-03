import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:owsomevpn/addmob/controller/add_controller.dart';
import 'package:owsomevpn/controllers/home_controller.dart';
import 'package:owsomevpn/extra_widgets/country_ping_widget.dart';
import 'package:owsomevpn/extra_widgets/speed_download_upload_widget.dart';
import 'package:owsomevpn/extra_widgets/timer_widget.dart';
import 'package:owsomevpn/models/vpn_status.dart';
import 'package:owsomevpn/pages/rateus.dart';
import 'package:owsomevpn/pages/select_server_screen.dart';
import 'package:owsomevpn/vpn_engine/vpn_engine.dart';
import 'package:share_plus/share_plus.dart';

class VpnHomePage extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final AdController adController = Get.put(AdController());
  VpnHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var sizeScreen = MediaQuery.of(context).size;

    /// VPN round button logic
    Widget vpnRoundButton() {
      return Column(
        children: [
          // button
          Semantics(
            button: true,
            child: InkWell(
              onTap: () {
                adController.showRewardedAd();
                homeController.connectToVpnNow();
                print("Attempting VPN connection...");
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        homeController.getRoundVpnButtonColor.withOpacity(.2)),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: homeController.getRoundVpnButtonColor
                          .withOpacity(.4)),
                  child: Container(
                    height: sizeScreen.height * .14,
                    width: sizeScreen.height * .14,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: homeController.getRoundVpnButtonColor
                            .withOpacity(.9)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.power_settings_new,
                            size: 30, color: Colors.white),
                        SizedBox(height: 6),
                        Text(
                          "${homeController.getRoundVpnButtonText}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          // connection state
          ,
          Container(
            margin: EdgeInsets.only(
              top: sizeScreen.height * .025,
            ),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color.fromARGB(255, 34, 47, 87)),
            child: Text(
              homeController.vpnConnectionState.value ==
                      VpnEngine.vpnDisconnectedNow
                  ? "Not Connected"
                  : homeController.vpnConnectionState
                      .replaceAll('_', " ")
                      .toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      );
    }

    Widget selectVpnButton() {
      return Container(
        padding:
            const EdgeInsets.only(left: 14, right: 10, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 29, 34, 66),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Obx(
                () => Row(
                  children: [
                    Image.asset(
                      homeController.vpnserver.value.countryLong.isEmpty
                          ? "assets/country_flags/default_country_location.png"
                          : "assets/country_flags/${homeController.vpnserver.value.countryShort.toLowerCase()}.png", // France flag
                      width: homeController.vpnserver.value.countryLong.isEmpty
                          ? 30
                          : 60,
                      height: homeController.vpnserver.value.countryLong.isEmpty
                          ? 50
                          : 50,
                    ),
                    const SizedBox(width: 20),
                    Text("Select Country / Location",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    // const SizedBox(width: 90),
                  ],
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      );
    }

    /// Listen to VPN stage stream
    VpnEngine.snapshotVpnStage().listen((event) {
      homeController.vpnConnectionState.value = event;
    });
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/country_flags/world.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(.4),
            ),
          ),
          // Content of the page
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Top bar with icons
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: const Icon(CupertinoIcons.bolt,
                            color: Colors.white),
                        onTap: () {
                          Get.to(() => RateUsPage());
                        },
                      ),
                      GestureDetector(
                        child: const Icon(
                            CupertinoIcons.arrowshape_turn_up_right,
                            color: Colors.white),
                        onTap: () {
                          Share.share('Check out this awesome app!');
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Obx(() => CountryPingWidget(
                    countryName: homeController.vpnserver.value.countryLong
                        .replaceAll(" Republic of", ""),
                    ping: homeController.vpnserver.value.ping)),
                const SizedBox(height: 25),
                // connecting button
                Obx(() => vpnRoundButton()),
                const SizedBox(height: 15),
                // Showing connection Time
                Obx(() => TimerWidget(
                      intiTimeNow: homeController.vpnConnectionState.value ==
                          VpnEngine.vpnConnectedNow,
                    )),
                const SizedBox(height: 15),
                // Server details
                InkWell(
                    onTap: () {
                      adController.showInterstitialAd();
                      Get.to(() => SelectServerIpScreen());
                    },
                    child: selectVpnButton()),
                const SizedBox(height: 25),
                // Upload and download speeds
                StreamBuilder<VpnStatus?>(
                  initialData: VpnStatus(),
                  stream: VpnEngine.snapshotVpnStatus(),
                  builder: (context, dataSnapshot) {
                    // Check if VPN is connected, otherwise show '0 kbps'
                    bool isConnected =
                        homeController.vpnConnectionState.value ==
                            VpnEngine.vpnConnectedNow;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Download Speed
                        SpeedDisplayWidget(
                          cupertinoIcon: CupertinoIcons.arrow_down_circle,
                          label: 'Download speed',
                          materialIcon: Icons.arrow_downward,
                          speed: isConnected
                              ? "${dataSnapshot.data?.byteIn ?? '0 kbps'}" // Show actual speed if connected
                              : "0 kbps", // Show 0 kbps if disconnected
                        ),
                        const SizedBox(width: 10),
                        // Upload Speed
                        SpeedDisplayWidget(
                          cupertinoIcon: CupertinoIcons.arrow_up_circle,
                          label: 'Upload speed',
                          materialIcon: Icons.arrow_upward,
                          speedColor: Colors.redAccent,
                          speed: isConnected
                              ? "${dataSnapshot.data?.byteOut ?? '0 kbps'}" // Show actual speed if connected
                              : "0 kbps", // Show 0 kbps if disconnected
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: sizeScreen.height * .045,
                ),
                Obx(() {
                  if (adController.isBannerAdLoaded.value) {
                    return Container(
                      height: adController.bannerAd.size.height.toDouble(),
                      width: adController.bannerAd.size.width.toDouble(),
                      child: AdWidget(ad: adController.bannerAd),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
