import 'package:flutter/material.dart';

class SearchBottomSheet extends StatefulWidget {
  final Function(String) onZoneSelected; // Callback function

  const SearchBottomSheet({super.key, required this.onZoneSelected});

  @override
  _SearchBottomSheetState createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  String? selectedZone; // Biến để lưu khu vực đã chọn

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 300, // Chiều cao của bottom sheet
      child: Column(
        children: [
          const Text(
            'Chọn khu vực',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Zone A'),
                  value: 'Zone A',
                  groupValue: selectedZone,
                  onChanged: (value) {
                    setState(() {
                      selectedZone = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Zone B'),
                  value: 'Zone B',
                  groupValue: selectedZone,
                  onChanged: (value) {
                    setState(() {
                      selectedZone = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Zone C'),
                  value: 'Zone C',
                  groupValue: selectedZone,
                  onChanged: (value) {
                    setState(() {
                      selectedZone = value;
                    });
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedZone != null) {
                widget.onZoneSelected(selectedZone!); // Gọi callback
              }
              Navigator.pop(context); // Đóng bottom sheet
            },
            child: const Text('Xác nhận'),
          ),
        ],
      ),
    );
  }
}
