class NetworkSettings {
  String? wifiSubmask;

  String? wifiIpv6;

  String? wifiIp;

  String? wifiName;

  String? wifiBssId;

  String? wifiGateway;

  String? wifiBroadcast;



  NetworkSettings(this.wifiName, this.wifiBssId, this.wifiIp, this.wifiIpv6, this.wifiSubmask, this.wifiBroadcast, this.wifiGateway);
}