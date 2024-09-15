import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/rive_utils.dart';
import 'package:rive/rive.dart';
import 'package:flutter_application_1/View/history/history_screen.dart';
import 'package:flutter_application_1/View/home_screen.dart';
import 'package:flutter_application_1/View/profile_screen.dart';
import 'package:flutter_application_1/View/package_screen.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  int _selectedIndex = 0;

  // Danh sách các trang tương ứng với từng nút
  static final List<Widget> _screens = [
    HomeScreen(), // Trang Home (icon chat)
    PackageScreen(), // Trang Package (icon star)
    Placeholder(), // Trang Placeholder (icon home)
    HistoryScreen(), // Trang History (icon timer)
    ProfileScreen(), // Trang Profile (icon user)
  ];

  RiveAsset selectedBottomNav = bottomNavs.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex], // Hiển thị trang theo chỉ số được chọn
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 2),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.all(Radius.circular(24))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                  bottomNavs.length,
                  (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex =
                                index; // Cập nhật chỉ số khi nhấn vào nút
                          });

                          bottomNavs[index].input!.change(true);
                          if (bottomNavs[index] != selectedBottomNav) {
                            setState(() {
                              selectedBottomNav = bottomNavs[index];
                            });
                          }
                          Future.delayed(
                            const Duration(seconds: 1),
                            () {
                              bottomNavs[index].input!.change(false);
                            },
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedBar(
                                isActive:
                                    bottomNavs[index] == selectedBottomNav),
                            SizedBox(
                              height: 36,
                              width: 36,
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  bottomNavs[index] == selectedBottomNav
                                      ? Color.fromARGB(255, 30, 144,
                                          255) // Màu khi được chọn
                                      : Colors.grey, // Màu khi không được chọn
                                  BlendMode.srcIn, // Áp dụng blend mode
                                ),
                                child: RiveAnimation.asset(
                                  bottomNavs.first.src,
                                  artboard: bottomNavs[index].artboard,
                                  onInit: (artboard) {
                                    StateMachineController controller =
                                        RiveUtils.getRiveController(
                                      artboard,
                                      stateMachineName:
                                          bottomNavs[index].stateMachineName,
                                    );
                                    bottomNavs[index].input =
                                        controller.findSMI("active") as SMIBool;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: BoxDecoration(
        color: isActive ? Color.fromARGB(255, 30, 144, 255) : Colors.grey,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}

class RiveAsset {
  final String src, artboard, stateMachineName, title;
  late SMIBool? input;

  RiveAsset(this.src,
      {required this.artboard,
      required this.stateMachineName,
      required this.title,
      this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset('assets/icon.riv',
      artboard: "CHAT", stateMachineName: "CHAT_Interactivity", title: "Home"),
  RiveAsset('assets/icon.riv',
      artboard: "LIKE/STAR",
      stateMachineName: "STAR_Interactivity",
      title: "Package"),
  RiveAsset('assets/icon.riv',
      artboard: "HOME", // Nút Home đổi thành Placeholder
      stateMachineName: "HOME_Interactivity",
      title: "Placeholder"),
  RiveAsset('assets/icon.riv',
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity",
      title: "History"),
  RiveAsset('assets/icon.riv',
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
      title: "Profile"),
];
