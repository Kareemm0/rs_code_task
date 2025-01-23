import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> isOnline() async {
  final List<ConnectivityResult> connectivityResults =
      await Connectivity().checkConnectivity();
  return connectivityResults.contains(ConnectivityResult.mobile) ||
      connectivityResults.contains(ConnectivityResult.wifi);
}
