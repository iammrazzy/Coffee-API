import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  bool isConnected = false;

  @override
  void onInit() async {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _updateConnectionStatus(
      await _connectivity.checkConnectivity(),
    );
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    isConnected = connectivityResult != ConnectivityResult.none;
    update();
  }
}
