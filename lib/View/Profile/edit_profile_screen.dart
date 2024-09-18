import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
      TextEditingController(text: 'Dandi@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '12345');
  final TextEditingController _phoneController =
      TextEditingController(text: '09762266784');

  File? _image;

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

  void _saveProfile() {
    String name = _nameController.text;
    String dob = _dobController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;

    // Giả sử bạn thực hiện việc lưu dữ liệu ở đây (có thể lưu vào DB hoặc API)
    setState(() {
      // Cập nhật giao diện sau khi thay đổi dữ liệu
    });

    // Hiển thị thông báo cập nhật thành công
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Cập nhật thành công!")),
    );

    Navigator.pop(context);
  }

  Widget buildTextField(String labelText, String placeholder, IconData iconData,
      {int maxLines = 1, VoidCallback? onTap, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText, // Label for the TextField
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
              maxLines: maxLines,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: placeholder,
                prefixIcon: Icon(iconData),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5), // Đổi thành số cụ thể
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
