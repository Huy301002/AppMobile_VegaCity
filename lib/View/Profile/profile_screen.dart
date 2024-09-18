import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/Profile/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height *
              0.93, // Điều chỉnh chiều cao nếu cần
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
                        const Text("Veigar",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        const Text("mycity, mystate"),
                        const Text("+1234567890"),
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
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white, // Màu nền trắng
                              borderRadius: BorderRadius.circular(10), // Bo góc
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5), // Màu viền
                                width: 1, // Độ dày viền
                              ),
                            ),
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
                                                const EditProfileScreen()),
                                      );
                                    },
                                  ), // Mũi tên chỉ về hướng phải
                                ),
                                const ListTile(
                                  title: Text("Privacy Policy"),
                                  leading: Icon(Icons.security_outlined),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                  ), // Mũi tên chỉ về hướng phải
                                ),
                                const ListTile(
                                  title: Text("Share"),
                                  leading: Icon(Icons.share),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 12,
                                  ), // Mũi tên chỉ về hướng phải
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 120.0, left: 20, right: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(2), // Bo tròn các góc
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5), // Màu viền
                                width: 1, // Độ dày viền
                              ),
                            ),
                            child: const ListTile(
                              title: Text(
                                "Log out",
                                style: TextStyle(color: Colors.red),
                              ),
                              leading: Icon(
                                Icons.logout,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        )
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
