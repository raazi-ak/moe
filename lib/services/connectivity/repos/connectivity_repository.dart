import 'dart:async';
import 'dart:io';

class ConnectivityRepository {
  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  ConnectivityRepository() {
    _checkConnection(); // Initial check
    _startMonitoring();
  }

  Stream<bool> get connectivityStream => _controller.stream;

  void _startMonitoring() {
    Timer.periodic(Duration(seconds: 5), (timer) async {
      bool isConnected = await _checkConnection();
      _controller.add(isConnected);
    });
  }

  Future<bool> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<bool> checkInitialConnection() => _checkConnection();

  void dispose() {
    _controller.close();
  }
}
