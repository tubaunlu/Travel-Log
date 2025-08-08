import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_log/services/location_service.dart';
import 'package:travel_log/widgets/bottom_navbar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required String title});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _currentLatLng;
  String _address = '';
  int _currentIndex = 1;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getInitialLocation();
  }

  Future<void> _getInitialLocation() async {
    final position = await LocationService.getCurrentPosition();
    if (position != null) {
      final latLng = LatLng(position.latitude, position.longitude);
      final address = await LocationService.getAddressFromCoordinates(
          latLng.latitude, latLng.longitude);
      if (mounted) {
        setState(() {
          _currentLatLng = latLng;
          _address = address;
        });
      }
    }
  }
  bool isValidLatLng(LatLng? latLng) {
    return latLng != null && latLng.latitude != 0.0 && latLng.longitude != 0.0;
  }

  Future<void> searchPlace(String query) async {
    if (query.isEmpty) return;

    final coords = await LocationService.searchLocationByName(query);
    if (coords != null && isValidLatLng(coords)) {
      final address = await LocationService.getAddressFromCoordinates(
          coords.latitude, coords.longitude);
      if (mounted) {
        setState(() {
          _currentLatLng = coords;
          _address = address;
        });
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location not found")),
      );
    }
  }

  void _onTap(int index) {
    if (index == _currentIndex) return;
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 2:
        Navigator.pushNamed(context, '/create');
        break;
      case 3:
        Navigator.pushNamed(context, '/settings');
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: _currentLatLng == null || !isValidLatLng(_currentLatLng)
        ? const Center(child: CircularProgressIndicator())
        : Stack(
            children: [
              Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height / 3 , 
              child: FlutterMap(
                options: MapOptions(
                initialCenter: _currentLatLng!,
                initialZoom: 15.0,
                onTap: (tapPosition, latLng) async {
                  final address = await LocationService.getAddressFromCoordinates(
                    latLng.latitude, latLng.longitude);
                  setState(() {
                  _currentLatLng = latLng;
                  _address = address;
                  });
                },
                ),
                children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                  Marker(
                    width: 80,
                    height: 80,
                    point: _currentLatLng!,
                    child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                    ),
                  ),
                  ],
                ),
                ],
              ),
              ),
              Positioned(
              top: 60,
              left: 25,
              right: 14,
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(12),
                child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search for a place",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onSubmitted: searchPlace,
                ),
              ),
              ),
              Positioned(
              top: 10,
              left: 10,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(24),
                child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
              ),

              Positioned(
              bottom: 70,
              left: 16,
              right: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                if (_address.isNotEmpty)
                  Text(
                  "Address: $_address",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                  ),
                  
                const SizedBox(height: 30),
                SizedBox(
                  width: 120, 
                  height: 36,  
                  child: ElevatedButton(
                  onPressed: () async {
                    if (_currentLatLng == null || !isValidLatLng(_currentLatLng)) return;

                    final lat = _currentLatLng!.latitude;
                    final lon = _currentLatLng!.longitude;

                    final address = await LocationService.getAddressFromCoordinates(lat, lon);

                    if (!context.mounted) return;

                    setState(() {
                    _address = address;
                    });

                    await LocationService.saveLocation(lat, lon, address);

                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Location saved successfully'),
                      duration: Duration(seconds: 2),
                    ),
                    );

                    await Future.delayed(const Duration(seconds: 2));

                    if (!context.mounted) return;

                    Navigator.pushNamed(
                    context,
                    '/create',
                    arguments: _address,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.black,
                    elevation: 1,
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8), // padding de küçültüldü
                    textStyle: const TextStyle(fontSize: 14), // yazı boyutu küçültüldü
                  ),
                  child: const Text("Save Location"),
                  ),
                ),
                const SizedBox(height: 10),
                ],
              ),
              ),
            ],
          ),
    bottomNavigationBar: BottomNavBar(
      currentIndex: 1,
      onTap: (index) {
        _onTap(index);
      },
    ),
  );
}}