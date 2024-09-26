import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  // Vị trí cho từng zone (điều chỉnh tọa độ theo ý muốn)
  final LatLng zoneALocation = LatLng(21.0285, 105.804);
  final LatLng zoneBLocation = LatLng(21.005, 105.847);
  final LatLng zoneCLocation = LatLng(21.033, 105.839);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bản đồ các khu vực'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildZoneSection('Zone A', zoneALocation),
              const SizedBox(height: 20),
              _buildZoneSection('Zone B', zoneBLocation),
              const SizedBox(height: 20),
              _buildZoneSection('Zone C', zoneCLocation),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildZoneSection(String title, LatLng location) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 200, // Chiều cao cho bản đồ
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: location,
              zoom: 14.0,
            ),
            markers: {
              Marker(
                markerId: MarkerId(title),
                position: location,
              ),
            },
          ),
        ),
      ],
    );
  }
}
