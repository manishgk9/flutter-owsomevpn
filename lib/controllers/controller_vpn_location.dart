import 'package:get/get.dart';
import 'package:owsomevpn/app_pref/apppreferences.dart';
import 'package:owsomevpn/models/model.dart';
import 'package:owsomevpn/retreivevpns/gate_all_vpn_data.dart';

class ControllerVpnLocation {
  List<VpnServer> vpnServerList = AppPreferences.vpnList;
  RxBool isLoadingNewLocations = false.obs;
  Future<void> retreiveVpnInformation() async {
    isLoadingNewLocations.value = true;
    vpnServerList.clear();
    //api call to get vpn server list
    vpnServerList = await GateAllVpnData.retriveAllVpnServer();
    isLoadingNewLocations.value = false;
  }
}
