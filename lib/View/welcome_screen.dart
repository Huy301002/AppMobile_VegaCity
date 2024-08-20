import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_application_1/View/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E2EA),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Text(
                        "Welcome",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1200),
                      child: Text(
                        "Automatic identity verification which enables you to verify your identity",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[700], fontSize: 15),
                      )),
                ],
              ),
              FadeInUp(
                  duration: Duration(milliseconds: 1500),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/Illustration.png'))),
                  )),
              Column(
                children: <Widget>[
                  FadeInUp(
                      duration: Duration(milliseconds: 1500),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        color: Colors.blue[300],
                        height: 60,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "Let's get Started",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  // FadeInUp(
                  //     duration: Duration(milliseconds: 1600),
                  //     child: Container(
                  //       padding: EdgeInsets.only(top: 3, left: 3),
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(50),
                  //           border: Border(
                  //             bottom: BorderSide(color: Colors.black),
                  //             top: BorderSide(color: Colors.black),
                  //             left: BorderSide(color: Colors.black),
                  //             right: BorderSide(color: Colors.black),
                  //           )),
                  //       child: MaterialButton(
                  //         minWidth: double.infinity,
                  //         height: 60,
                  //         onPressed: () {
                  //           // Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                  //         },
                  //         color: Colors.yellow,
                  //         elevation: 0,
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(50)),
                  //         child: Text(
                  //           "Sign up",
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w600, fontSize: 18),
                  //         ),
                  //       ),
                  //     ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
