import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/home_screen.dart';
import 'package:flutter_application_1/core/component/dialog/loading_dialog.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:rive/rive.dart';
import 'package:animate_do/animate_do.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String validEmail = "Dandi@gmail.com";
  String validPassword = "12345";

  /// input form controller
  FocusNode emailFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();

  /// rive controller and input
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

  @override
  Widget build(BuildContext context) {
    print("Build Called Again");
    return Scaffold(
      backgroundColor: const Color(0xFFD6E2EA),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 32),
            FadeInDown(
              duration: Duration(milliseconds: 1000),
              child: Container(
                height: 64,
                width: 64,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Image(
                  image: AssetImage("assets/Logo.png"),
                ),
              ),
            ),
            const SizedBox(height: 32),
            FadeInDown(
              duration: Duration(milliseconds: 1200),
              child: Text(
                "Welcome to Vega City",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            FadeInDown(
              duration: Duration(milliseconds: 1500),
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
              duration: Duration(milliseconds: 1500),
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
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                        obscureText: true,
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
                          color: Colors.blue[300],
                          height: 60,
                          onPressed: () async {
                            emailFocusNode.unfocus();
                            passwordFocusNode.unfocus();

                            final email = emailController.text;
                            final password = passwordController.text;

                            if (email.isEmpty || password.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Error"),
                                  content: Text(
                                      "Account or password cannot be empty."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              showLoadingDialog(context);
                              await Future.delayed(
                                const Duration(milliseconds: 2000),
                              );
                              if (mounted) Navigator.pop(context);

                              if (email == validEmail &&
                                  password == validPassword) {
                                trigSuccess?.change(true);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                );
                              } else {
                                trigFail?.change(true);
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Error"),
                                    content: Text(
                                        "Account or password is incorrect."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        )),
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
