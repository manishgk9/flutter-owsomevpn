class VpnServer {
  late final String hostName;
  late final String ip;
  late final int ping;
  late final int speed;
  late final String countryLong;
  late final String countryShort;
  late final int numVpnSessions;
  late final String base64openVpnConfigData;

  VpnServer({
    required this.hostName,
    required this.ip,
    required this.ping,
    required this.speed,
    required this.countryLong,
    required this.countryShort,
    required this.numVpnSessions,
    required this.base64openVpnConfigData,
  });

  VpnServer.fromJson(Map<String, dynamic> jsonData) {
    hostName = jsonData['HostName'] ?? "";
    ip = jsonData['IP'] ?? "";
    ping = jsonData['Ping'] ?? 0;
    speed = jsonData['Speed'] ?? 0;
    countryLong = jsonData['CountryLong'] ?? "";
    countryShort = jsonData['CountryShort'] ?? "";
    numVpnSessions = jsonData['NumVpnSessions'] ?? 0;
    base64openVpnConfigData = jsonData['OpenVPN_ConfigData_Base64'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final jsonData = <String, dynamic>{}; // Fixed typo here
    jsonData['HostName'] = hostName;
    jsonData['IP'] = ip;
    jsonData['Ping'] = ping;
    jsonData['Speed'] = speed;
    jsonData['CountryLong'] = countryLong;
    jsonData['CountryShort'] = countryShort;
    jsonData['NumVpnSessions'] = numVpnSessions;
    jsonData['OpenVPN_ConfigData_Base64'] = base64openVpnConfigData;
    return jsonData;
  }
}
