class VpnStatus {
  String? byteIn;
  String? byteOut;
  String? duration;
  String? lastPacketRecieve;
  VpnStatus({this.byteIn, this.byteOut, this.duration, this.lastPacketRecieve});

  factory VpnStatus.fromJson(Map<String, dynamic> jsonData) => VpnStatus(
      byteIn: jsonData['byte_in'] ?? '00:00:00',
      byteOut: jsonData['byte_out'] ?? '0',
      duration: jsonData['duration'] ?? '0',
      lastPacketRecieve: jsonData['last_packet_receive']);

  Map<String, dynamic> toJson() => {
        'byte_in': byteIn,
        'byte_out': byteOut,
        'duration': duration,
        'last_packet_receive': lastPacketRecieve
      };
}
