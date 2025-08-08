import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class LocationService {
  static Future<bool> _requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return permission == LocationPermission.always || permission == LocationPermission.whileInUse;
  }

  static Future<bool> _isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  static Future<Position?> getCurrentPosition() async {
    if (!await _isLocationServiceEnabled()) {
      if (kDebugMode) print("Konum servisi kapalı.");
      return null;
    }

    if (!await _requestPermission()) {
      if (kDebugMode) print("Konum izni verilmedi.");
      return null;
    }

    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      if (kDebugMode) print("Konum alınırken hata oluştu: $e");
      return null;
    }
  }

  static Future<String> getAddressFromCoordinates(double lat, double lon) async {
    if (kIsWeb) {
      return 'Address information is not supported on the web platform';
    }

    try {
      final placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        final street = place.street ?? '';
        final subLocality = place.subLocality ?? '';
        final locality = place.locality ?? '';
        final subAdmin = place.subAdministrativeArea ?? '';
        final admin = place.administrativeArea ?? '';
        final country = place.country ?? '';

        final addressParts = [
          street,
          subLocality,
          locality,
          subAdmin,
          admin,
          country
        ].where((part) => part.isNotEmpty).toList();

        return addressParts.isNotEmpty
            ? addressParts.join(', ')
            : 'Address not found';
      } else {
        return 'Address not found';
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error getting address: $e");
      }
      return 'Unknown address';
    }
  }

  static Future<void> saveLocation(double lat, double lon, String address) async {
    try {
      await FirebaseFirestore.instance.collection('locations').add({
        'latitude': lat,
        'longitude': lon,
        'address': address,
        'timestamp': FieldValue.serverTimestamp(),
      });
      if (kDebugMode) print("Location saved successfully");
    } catch (e) {
      if (kDebugMode) print("Error saving location: $e");
    }
  }

  static Future<LatLng?> searchLocationByName(String placeName) async {
        final url = Uri.parse(
    'https://nominatim.openstreetmap.org/search?q=Istanbul, Turkey&format=json&limit=1');
    
    

    final response = await http.get(
      url,
      headers: {
        'User-Agent': 'YourAppNameHere/1.0 (your@email.com)', 
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data != null && data.isNotEmpty) {
        final lat = double.parse(data[0]['lat']);
        final lon = double.parse(data[0]['lon']);
        return LatLng(lat, lon);
      }
     } else {
      if (kDebugMode) {
        print("No data found for $placeName");
      }
      return null;
    }
    return null;
  }
}
  bool isValidCoordinates(LatLng? latLng) {
    return latLng != null && latLng.latitude != 0.0 && latLng.longitude != 0.0;
  }

  Future<LatLng?> getCoordinatesFromAddress(String query) async {
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1');

    final response = await http.get(
      url,
      headers: {
        'User-Agent': 'YourAppNameHere/1.0 (your@email.com)', 
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data != null && data.isNotEmpty) {
        final lat = double.parse(data[0]['lat']);
        final lon = double.parse(data[0]['lon']);
        return LatLng(lat, lon);
      }
    } else {
      if (kDebugMode) {
        print("Error: ${response.statusCode}");
      }
      return null;
    }
    return null;
  }

    

