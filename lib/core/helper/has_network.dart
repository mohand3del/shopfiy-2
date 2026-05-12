import 'dart:async';
import 'dart:io';

class InternetConnectionService {
  final _controller = StreamController<bool>.broadcast();
  Timer? _timer;

  InternetConnectionService() {
    _checkPeriodically();
  }

  Stream<bool> get onStatusChange => _controller.stream;

  void _checkPeriodically() {
    _timer = Timer.periodic(Duration(seconds: 5), (_) async {
      final hasInternet = await _hasInternetAccess();
      _controller.add(hasInternet);
    });
  }

  Future<bool> _hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<void> triggerManualCheck() async {
    await _checkAndEmit();
  }

  Future<void> _checkAndEmit() async {
    final isConnected = await _hasInternetAccess();
    _controller.add(isConnected);
  }

  void dispose() {
    _timer?.cancel();
    _controller.close();
  }
}
