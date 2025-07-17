import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<bool> _requestPermission() async {
    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }
    return perm == LocationPermission.always ||
        perm == LocationPermission.whileInUse;
  }

  static Future<Position?> current() async {
    if (!await _requestPermission()) return null;
    return Geolocator.getCurrentPosition();
  }

  static Stream<Position> stream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
      ),
    );
  }
}
