import 'package:expense_tracker/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/constants/used_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static String id = "LoginScreen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool visible = false ;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;
  Future<void> LogIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      setState(() {
        errorMessage = null;
      });

      Navigator.pushReplacementNamed(context, MainScreen.id);

    } catch (error) {
      setState(() {
        errorMessage = error.toString();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25,horizontal: 15),
            child:Column (

              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Welcome,",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 25),),
                SizedBox(height: 15,),
                Text("Login with your employee ID,",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                SizedBox(
                  height: 35,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller:   emailController,
                  decoration: InputDecoration(
                    hintText: "Enter your Employee Email",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
                    ),
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                  ),
                  cursorColor: usedColor,
                ),
                SizedBox(height: 15,),
                TextField(
                  onTap: (){
                    setState(() {
                      visible = !visible;
                    });
                  },
                    controller: passwordController,
                    decoration: InputDecoration(
                    hintText: "Enter Password",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
                    ),
                    hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
                  ),
                  cursorColor: usedColor,
                ),

                SizedBox(height: 15,),
                Spacer(),
                AnimatedOpacity(
                  opacity:visible ? 1.0 : 0.5,
                  duration: const Duration(milliseconds: 500),
                  child: UsedGradientButton(
                      textButton: "Login",
                      onPressedFunction: (){
                        LogIn();
                       })
                )
              ],
            )
        ),
      )
    );
  }
}
