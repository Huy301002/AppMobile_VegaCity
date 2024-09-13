import 'package:flutter/material.dart';
import 'package:flutter_application_1/Component/bottomNavbar.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

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
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            ClipPath(
              // clipper: MyClipper(),
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
                  height: MediaQuery.of(context).size.height * .9,
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 80),
                  child: Column(
                    children: [
                      Text("Veigar",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      Text("mycity, mystate"),
                      Text("+1234567890"),
                      SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: Container(
                          width: 55,
                          height: 35,
                          child: const Center(
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text("42",
                                    style: TextStyle(
                                        color: Color(0xff525f7f),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 5),
                                Text("Total Rides",
                                    style: TextStyle(
                                        color: Color(0xff525f7f),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              children: [
                                Text("10",
                                    style: TextStyle(
                                        color: Color(0xff525f7f),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 5),
                                Text("Cancelled",
                                    style: TextStyle(
                                        color: Color(0xff525f7f),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              children: [
                                Text("4.5",
                                    style: TextStyle(
                                        color: Color(0xff525f7f),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Text("Rating",
                                    style: TextStyle(
                                        color: Color(0xff525f7f),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, left: 20, right: 30, bottom: 10),
                        child: Divider(
                          thickness: 0.8,
                          color: Colors.blueGrey,
                        ),
                      ),
                      ListTile(
                        title: Text("Privacy Policy"),
                        leading: Icon(Icons.security_outlined),
                      ),
                      ListTile(
                        title: Text("Share"),
                        leading: Icon(Icons.share),
                      ),
                      ListTile(
                        title: Text(
                          "Log out",
                          style: TextStyle(color: Colors.red),
                        ),
                        leading: Icon(
                          Icons.logout,
                          color: Colors.red,
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
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 4,
        onTap: (index) {},
      ),
    );
  }
}

// class MyClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path()
//       ..lineTo(0, size.height)
//       ..lineTo(size.width, size.height - 30)
//       ..lineTo(size.width, 0)
//       ..close();
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
// }
