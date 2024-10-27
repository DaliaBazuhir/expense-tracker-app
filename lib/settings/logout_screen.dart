import 'package:expense_tracker/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/used_widgets.dart';
class Logout extends StatelessWidget {
  static  String id ="logout";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> LogOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child:
      Padding(padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

              UsedGradientButton(
                textButton: "Log Out",
                onPressedFunction:()=> LogOut(context),
              )

        ],
      )
      )
      ),
    );
  }
}
