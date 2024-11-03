import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:owsomevpn/models/vpn_configuration.dart';
import 'package:owsomevpn/models/vpn_status.dart';

class VpnEngine {
  /// Native channels
  static const String eventChannelVpnStage = "vpnStage";
  static const String eventChannelVpnStatus = "vpnStatus";
  static const String methodChannelVpnControl = "vpnControl";

  /// VPN connection stage snapshot
  static Stream<String> snapshotVpnStage() => EventChannel(eventChannelVpnStage)
      .receiveBroadcastStream()
      .cast<String>();

  /// VPN connection status snapshot
  static Stream<VpnStatus?> snapshotVpnStatus() =>
      EventChannel(eventChannelVpnStatus)
          .receiveBroadcastStream()
          .map((eventStatus) => VpnStatus.fromJson(jsonDecode(eventStatus)))
          .cast();

  /// Start VPN connection
  static Future<void> startVpnNow(VpnConfiguration vpnConfiguration) async {
    try {
      return MethodChannel(methodChannelVpnControl).invokeMethod("start", {
        "config": vpnConfiguration.config,
        "country": vpnConfiguration.countryName,
        "username": vpnConfiguration.username,
        "password": vpnConfiguration.password,
      });
    } catch (e) {
      print("Error starting VPN: $e");
      throw e;
    }
  }

  /// Stop VPN connection
  static Future<void> stopVpnNow() async {
    try {
      return MethodChannel(methodChannelVpnControl).invokeMethod("stop");
    } catch (e) {
      print("Error stopping VPN: $e");
      throw e;
    }
  }

  static Future<void> killSwitchOpenNow() async {
    try {
      return MethodChannel(methodChannelVpnControl).invokeMethod("kill_switch");
    } catch (e) {
      print("Error opening kill switch: $e");
      throw e;
    }
  }

  static Future<void> refreshStageNow() async {
    try {
      return MethodChannel(methodChannelVpnControl).invokeMethod("refresh");
    } catch (e) {
      print("Error refreshing stage: $e");
      throw e;
    }
  }

  static Future<String?> getStageNow() async {
    try {
      return MethodChannel(methodChannelVpnControl).invokeMethod("stage");
    } catch (e) {
      print("Error getting stage: $e");
      throw e;
    }
  }

  static Future<bool> isConnectedNow() async {
    final stage = await getStageNow();
    return stage?.toLowerCase() == "connected";
  }

  /// VPN connection stages
  static const String vpnConnectedNow = "connected";
  static const String vpnDisconnectedNow = "disconnected";
  static const String vpnWaitConnectionNow = "wait_connection";
  static const String vpnAuthenticatingNow = "authenticating";
  static const String vpnReconnectNow = "reconnect";
  static const String vpnNoConnectionNow = "no_connection";
  static const String vpnConnectingNow = "connecting";
  static const String vpnPrepareNow = "prepare";
  static const String vpnDeniedNow = "denied";
}
