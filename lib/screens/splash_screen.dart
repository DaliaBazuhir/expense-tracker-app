import 'dart:async';
import 'package:expense_tracker/constants/used_widgets.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:expense_tracker/screens/login_screen.dart';


class SplashScreen extends StatefulWidget {
  static String id = "SplashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1), ()=>Navigator.pushReplacementNamed(context,LoginScreen.id));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DefaultTextStyle(
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:usedColor,),
              child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText("Expense Tracker",),
                  ],isRepeatingAnimation: false,
              )),
        ),

    );
  }
}
