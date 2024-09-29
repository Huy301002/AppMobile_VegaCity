import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/signup/forgetpassword_screen.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_application_1/auth/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();

  FocusNode emailFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();

  bool _isObscure = true;

  StateMachineController? controller;
  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  @override
  void initState() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);
    super.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  void togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
      isHandsUp?.change(_isObscure);
    });
  }

  Future<void> _login() async {
    try {
      final email = emailController.text;
      final password = passwordController.text;

      // Check for empty fields
      if (email.isEmpty || password.isEmpty) {
        _showErrorDialog("Tài khoản hoặc mật khẩu không được để trống.");
        return;
      }

      // Call login method from AuthService
      final result = await _authService.login(email, password);

      // Check if the login was successful
      if (result.containsKey('accessToken')) {
        // Save tokens and user ID to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', result['accessToken']);
        await prefs.setString('userId', result['userId']);

        // Log the saved values for debugging
        print('Token đã lưu: ${prefs.getString('token')}');
        print('User ID đã lưu: ${prefs.getString('userId')}');

        // Navigate to Home screen
        Get.offNamed('/Home');
      } else {
        // Show error message if login failed
        _showErrorDialog(
            result['error'] ?? "Tài khoản hoặc mật khẩu không chính xác.");
      }
    } catch (e) {
      print('Đăng nhập thất bại: $e');
      _showErrorDialog("Đăng nhập thất bại. Vui lòng thử lại.");
    }
  }

// Helper method to show error dialogs
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Lỗi"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E2EA),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 32),
            FadeInDown(
              duration: const Duration(milliseconds: 1000),
              child: Container(
                height: 64,
                width: 64,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 32),
            FadeInDown(
              duration: const Duration(milliseconds: 1200),
              child: Text(
                "Welcome to Vega City",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            FadeInDown(
              duration: const Duration(milliseconds: 1500),
              child: SizedBox(
                height: 250,
                width: 250,
                child: RiveAnimation.asset(
                  'assets/animated_login_character_.riv',
                  fit: BoxFit.fitHeight,
                  stateMachines: const ["Login Machine"],
                  onInit: (artboard) {
                    controller = StateMachineController.fromArtboard(
                      artboard,
                      "Login Machine",
                    );
                    if (controller == null) return;

                    artboard.addController(controller!);
                    isChecking = controller?.findInput("isChecking");
                    numLook = controller?.findInput("numLook");
                    isHandsUp = controller?.findInput("isHandsUp");
                    trigSuccess = controller?.findInput("trigSuccess");
                    trigFail = controller?.findInput("trigFail");
                  },
                ),
              ),
            ),
            FadeInDown(
              duration: const Duration(milliseconds: 1500),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: TextField(
                        focusNode: emailFocusNode,
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                        onChanged: (value) {
                          numLook?.change(value.length.toDouble());
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: TextField(
                        focusNode: passwordFocusNode,
                        controller: passwordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: togglePasswordVisibility,
                          ),
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 64,
                      child: MaterialButton(
                        minWidth: double.infinity,
                        color: const Color.fromARGB(255, 30, 144, 255),
                        height: 60,
                        onPressed: () async {
                          emailFocusNode.unfocus();
                          passwordFocusNode.unfocus();
                          await _login();
                        },
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgetPasswordScreen()),
                          );
                        },
                        child: const Text("Forgot Password?"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
