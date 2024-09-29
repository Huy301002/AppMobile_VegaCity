import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_application_1/auth/auth_service.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  List<Map<String, dynamic>> zones = [];
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    _fetchZones();
  }

  Future<void> _fetchZones() async {
    try {
      final response = await authService.getZones();
      if (response.containsKey('error')) {
        print('Error fetching zones: ${response['error']}');
      } else {
        setState(() {
          zones = List<Map<String, dynamic>>.from(response['data']);
        });
      }
    } catch (e) {
      print('Error fetching zones: $e');
    }
  }

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
            children: zones.isNotEmpty
                ? zones.map((zone) {
                    final String title = zone['name']; // Lấy tên khu vực
                    final LatLng location = LatLng(
                      zone['latitude'] ?? 0.0, // Lấy latitude từ API
                      zone['longitude'] ?? 0.0, // Lấy longitude từ API
                    );
                    return _buildZoneSection(title, location);
                  }).toList()
                : [
                    const CircularProgressIndicator()
                  ], // Hiển thị loader khi chưa có dữ liệu
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
