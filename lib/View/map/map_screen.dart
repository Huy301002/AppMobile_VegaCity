import 'package:flutter/material.dart';

class ZoneScreen extends StatefulWidget {
  const ZoneScreen({super.key});

  @override
  State<ZoneScreen> createState() => _ZoneScreenState();
}

class _ZoneScreenState extends State<ZoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Zones'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Zone A - Hình chữ nhật đứng
            ZoneWidget(
              title: 'Zone A',
              color: Colors.blueAccent,
              mapImage: 'assets/map1_1.png',
              isPortrait: true,
            ),
            const SizedBox(height: 20),

            // Zone B - Hình chữ nhật đứng
            ZoneWidget(
              title: 'Zone B',
              color: Colors.blueAccent,
              mapImage: 'assets/mapb.png',
              isPortrait: true,
            ),
            const SizedBox(height: 20),

            // Zone C - Hình chữ nhật ngang (giữ nguyên)
            ZoneWidget(
              title: 'Zone C',
              color: Colors.blueAccent,
              mapImage: 'assets/mapc.png',
              isPortrait: false,
            ),
          ],
        ),
      ),
    );
  }
}

class ZoneWidget extends StatelessWidget {
  final String title;
  final Color color;
  final String mapImage;
  final bool isPortrait;

  const ZoneWidget({
    Key? key,
    required this.title,
    required this.color,
    required this.mapImage,
    required this.isPortrait,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: isPortrait
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image on the left for portrait mode
                Stack(
                  children: [
                    Container(
                      height: 350, // Chiều cao lớn hơn cho hình chữ nhật đứng
                      width: 200, // Chiều rộng nhỏ hơn cho hình chữ nhật đứng
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: color, width: 2),
                        image: DecorationImage(
                          image: AssetImage(mapImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Nút "View Map" ở góc dưới phải
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: ElevatedButton(
                        onPressed: () {
                          // Xử lý sự kiện khi nhấn nút "View Map"
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color, // Màu nút theo màu Zone
                        ),
                        child: const Text('View Map',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20), // Khoảng cách giữa ảnh và text

                // Text on the right
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Map illustration for $title. This is a placeholder for the map until Google Maps API is integrated.',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Zone Title
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
                // Stack để chứa ảnh và nút "View Map"
                Stack(
                  children: [
                    Container(
                      height: 200, // Chiều cao cho hình chữ nhật ngang
                      width: double.infinity, // Chiều rộng tối đa
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: color, width: 2),
                        image: DecorationImage(
                          image: AssetImage(mapImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Nút "View Map" ở góc dưới phải
                    Positioned(
                      bottom: 10,
                      right: 15,
                      child: ElevatedButton(
                        onPressed: () {
                          // Xử lý sự kiện khi nhấn nút "View Map"
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color, // Màu nút theo màu Zone
                        ),
                        child: const Text('View Map',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10), // Khoảng cách giữa ảnh và mô tả

                // Description Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'This is a description for $title. You can add more details about this zone here.',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
    );
  }
}
