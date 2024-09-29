import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/profile/change_password.dart';
import 'package:flutter_application_1/View/profile/edit_profile_screen.dart';
import 'package:flutter_application_1/View/signup/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/auth/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';
  String userEmail = '';
  String userPhone = '';

  AuthService authService = AuthService(); // Khởi tạo đối tượng

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      if (userId != null) {
        print('Found userId: $userId'); // Log the found userId

        // Fetch user info using the AuthService
        final userInfo = await authService.getUserInfo(userId);

        // Check for errors in the response
        if (userInfo.containsKey('error')) {
          print('Error fetching user info: ${userInfo['error']}');
          return; // Exit the function if there's an error
        }

        // Extract the user data safely
        final user = userInfo['data']['user'];
        if (user != null) {
          setState(() {
            userName =
                user['fullName'] ?? 'N/A'; // Set userName or default to 'N/A'
          });
          print('User info fetched successfully: $user'); // Log the user info
        } else {
          print('Error: userInfo does not contain expected data');
        }
      } else {
        print(
            'No userId found in SharedPreferences'); // Log if userId is not found
      }
    } catch (e) {
      print('Error fetching user info: $e'); // Log any errors encountered
    }
  }

  // Hàm hiển thị Snackbar thông báo tính năng đang phát triển
  void _showDevelopmentMessage(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature đang được phát triển!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Hàm hiển thị BottomSheet cho cài đặt
  void _showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text("Thông tin ứng dụng"),
                onTap: () {
                  Navigator.pop(context); // Đóng BottomSheet
                  _showDevelopmentMessage("Thông tin ứng dụng");
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.lock_outline),
                title: const Text("Đổi mật khẩu"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePasswordScreen()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Hàm đăng xuất
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    // Xóa thông tin người dùng đã lưu
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
    await prefs.remove('userId');

    // Điều hướng về trang đăng nhập
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.93,
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    color: Colors.white54,
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(top: 80),
                    child: Column(
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(userEmail),
                        Text(userPhone),
                        const SizedBox(height: 8),
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 10.0, left: 20, right: 20, bottom: 10),
                          child: Divider(
                            thickness: 0.8,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text("Profile"),
                                leading: const Icon(Icons.person),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const EditProfileScreen(),
                                      ),
                                    );
                                  },
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 15,
                                    right: 7), // Đẩy icon và chữ sang trái
                              ),
                              ListTile(
                                title: const Text("Privacy Policy"),
                                leading: const Icon(Icons.security_outlined),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                ),
                                onTap: () {
                                  _showDevelopmentMessage("Privacy Policy");
                                },
                              ),
                              ListTile(
                                title: const Text("Report"),
                                leading: const Icon(Icons.report_gmailerrorred),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                ),
                                onTap: () {
                                  _showDevelopmentMessage("Report");
                                },
                              ),
                              ListTile(
                                title: const Text("Settings"),
                                leading: const Icon(Icons.settings),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                ),
                                onTap: () {
                                  _showSettingsBottomSheet(context);
                                },
                              ),
                              ListTile(
                                title: const Text("Log out",
                                    style: TextStyle(color: Colors.red)),
                                leading: const Icon(
                                  Icons.logout,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  _logout(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: MediaQuery.of(context).size.width / 2 - 65,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child: Image.asset(
                    "assets/Logo.png",
                    width: 140,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
