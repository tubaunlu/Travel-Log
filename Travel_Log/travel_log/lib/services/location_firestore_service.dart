import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart'; 

class LocationService {
  static Future<void> saveLocation(double lat, double lon, String address) async {
    try {
      await FirebaseFirestore.instance.collection('locations').add({
        'latitude': lat,
        'longitude': lon,
        'address': address,
        'timestamp': FieldValue.serverTimestamp(), 
      });
    } catch (e) {
      if (kDebugMode) {
        if (kDebugMode) {
          print("An error occurred while saving the location: $e");
        }
      }
    }
  }
}
