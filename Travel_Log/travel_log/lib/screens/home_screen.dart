// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// // ignore: depend_on_referenced_packages
// import 'package:latlong2/latlong.dart';
// import '../services/location_service.dart';
// import '../services/log_service.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final mapController = MapController();
//   StreamSubscription? _locSub;
//   LatLng? _currentLatLng;

//   @override
//   void initState() {
//     super.initState();
//     _initLocation();
//  // 5 dakikada bir konum kaydı
// Timer.periodic(const Duration(minutes: 5), (timer) async {
//   if (!mounted) {
//     timer.cancel();
//     return;
//   }

//   final pos = await LocationService.current();
//   if (pos != null) {
//     final text = 'Lat: ${pos.latitude}, Lng: ${pos.longitude}';
//     await LogService.appendLog(text);
//   }
// });

//   }

//   Future<void> _initLocation() async {
//     final pos = await LocationService.current();
//     if (pos == null) return;

//     final latLng = LatLng(pos.latitude, pos.longitude);
//     setState(() => _currentLatLng = latLng);

//     // Dinamik konum güncellemesi
//     _locSub = LocationService.stream().listen((p) {
//       final newLatLng = LatLng(p.latitude, p.longitude);
//       setState(() => _currentLatLng = newLatLng);
//       mapController.move(newLatLng, mapController.camera.zoom);
//     });
//   }

//   @override
//   void dispose() {
//     _locSub?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final latLng = _currentLatLng;

//     return Scaffold(
//       appBar: AppBar(title: const Text('Harita')),
//       body: latLng == null
//           ? const Center(child: CircularProgressIndicator())
//           : FlutterMap(
//               mapController: mapController,
//               options: MapOptions(
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                   userAgentPackageName: 'com.example.flutter_application_2',
//                 ),
//                 MarkerLayer(
//                   markers: [
//                     Marker(
//                       width: 40,
//                       height: 40,
//                       point: latLng,
//                       child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           if (latLng != null) {
//             mapController.move(latLng, 15.0);
//           }
//         },
//         icon: const Icon(Icons.my_location),
//         label: const Text('Konuma Git'),
//       ),
//     );
//   }
// }
