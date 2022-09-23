import 'package:simple_bible/models/network_settings.dart';
import 'package:network_info_plus/network_info_plus.dart';

class NetworkService {
  Future<NetworkSettings> getNetworkData() async {
    final info = NetworkInfo();
    // ConnectivityResult connectivity = await Connectivity().checkConnectivity();

    String? wifiName = await info.getWifiName(); // FooNetwork
    String? wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66
    String? wifiIP = await info.getWifiIP(); // 192.168.1.43
    String? wifiIPv6 =
        await info.getWifiIPv6(); // 2001:0db8:85a3:0000:0000:8a2e:0370:7334
    String? wifiSubmask = await info.getWifiSubmask(); // 255.255.255.0
    String? wifiBroadcast = await info.getWifiBroadcast(); // 192.168.1.255
    String? wifiGateway = await info.getWifiGatewayIP(); // 192.168.1.1
    NetworkSettings settings = NetworkSettings(wifiName, wifiBSSID, wifiIP,
        wifiIPv6, wifiSubmask, wifiBroadcast, wifiGateway);

    return settings;
  }

  String buildNetworkSettings(NetworkSettings networkSettings, String name) {
    String text = '\n\nName: $name\nValue: ${networkSettings.wifiIp}'
        // '\nHost: ${networkSettings.hostName}'
        // '\nConnection Name: ${connectivity.name}'
        '\nGateway: ${networkSettings.wifiGateway ?? 'n/a'}'
        '\nWifi Name: ${networkSettings.wifiName}'
        '\nWifi Broadcast: ${networkSettings.wifiBroadcast}'
        '\nWifi Ipv4: ${networkSettings.wifiIp}'
        '\nWifi Ipv6: ${networkSettings.wifiIpv6}'
        '\nWifi BssId: ${networkSettings.wifiBssId}'
        '\nWifi Submask: ${networkSettings.wifiSubmask}';
    // '\nType: ${networkSettings.type.name}';

    // text += networkSettings.type.name.contains('IPv4') ?  '\nRaw Address:${networkSettings.rawAddress.toString().replaceAll(', ', '.')}': '\nRaw Address:${ipInfo.rawAddress.toString().replaceAll(', ', ':')}';

    return text;
  }
}
