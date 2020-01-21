import 'package:geolocator/geolocator.dart';

class LocationRepository {
  getCurrentLocation() async {
    return await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }
}