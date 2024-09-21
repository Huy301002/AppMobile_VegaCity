import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart'; // Thêm import cho Dio

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Huy');
  final TextEditingController _dobController =
      TextEditingController(text: '30/10/2002');
  final TextEditingController _emailController =
      TextEditingController(text: 'hoangthse161468@fpt.edu.vn');
  final TextEditingController _phoneController =
      TextEditingController(text: '09762266749');

  File? _image;
  final Dio _dio = Dio(); // Khởi tạo Dio

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    String name = _nameController.text;
    String dob = _dobController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;

    // Tạo payload cho API
    final Map<String, dynamic> payload = {
      'name': name,
      'dob': dob,
      'email': email,
      'phone': phone,
      // Bạn có thể thêm hình ảnh nếu cần
    };

    try {
      final response = await _dio.put('/user/update',
          data: payload); // Đường dẫn API tương ứng
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cập nhật thành công!")),
        );
        Navigator.pop(context);
      } else {
        throw Exception('Cập nhật không thành công: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Có lỗi xảy ra: $e")),
      );
    }
  }

  void _saveProfile() {
    _updateProfile(); // Gọi phương thức cập nhật
  }

  Widget buildTextField(String labelText, String placeholder, IconData iconData,
      {int maxLines = 1, VoidCallback? onTap, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            child: TextField(
              controller: (labelText == 'Tên')
                  ? _nameController
                  : (labelText == 'Ngày sinh (dd/mm/yyyy)')
                      ? _dobController
                      : (labelText == 'Email')
                          ? _emailController
                          : (labelText == 'Số điện thoại')
                              ? _phoneController
                              : null,
              maxLines: maxLines,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: placeholder,
                prefixIcon: Icon(iconData),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            ClipPath(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 30, 144, 255),
                      Color.fromARGB(255, 16, 78, 139)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100,
              bottom: 100,
              right: 30,
              left: 30,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Container(
                  color: Colors.white54,
                  height: MediaQuery.of(context).size.height * .9,
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 80),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 50.0),
                    child: Column(
                      children: [
                        buildTextField(
                          'Tên',
                          'Huy',
                          Icons.person,
                        ),
                        const SizedBox(height: 10),
                        buildTextField(
                          'Ngày sinh (dd/mm/yyyy)',
                          '30/10/2002',
                          Icons.calendar_today,
                          keyboardType: TextInputType.datetime,
                        ),
                        const SizedBox(height: 10),
                        buildTextField(
                          'Email',
                          'Dandi@gmail.com',
                          Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 10),
                        buildTextField(
                          'Số điện thoại',
                          '09762266784',
                          Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(3),
                                      bottomLeft: Radius.circular(3),
                                    ),
                                  ),
                                  textStyle:
                                      const TextStyle(color: Colors.white),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _saveProfile,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 30, 144, 255),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(3),
                                      bottomRight: Radius.circular(3),
                                    ),
                                  ),
                                  textStyle:
                                      const TextStyle(color: Colors.white),
                                ),
                                child: const Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: MediaQuery.of(context).size.width / 2 - 65,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child: _image == null
                    ? Image.asset(
                        "assets/Logo.png",
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        _image!,
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Positioned(
              top: 130,
              left: MediaQuery.of(context).size.width / 2 + 46,
              child: GestureDetector(
                onTap: _pickImage,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child: Container(
                    color: const Color.fromARGB(255, 30, 144, 255),
                    width: 30,
                    height: 30,
                    child: const Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
