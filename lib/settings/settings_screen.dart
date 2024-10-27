import 'package:expense_tracker/Settings/FinanicalDetails/bank_management_page.dart';
import 'package:expense_tracker/Settings/logout_screen.dart';
import 'package:expense_tracker/Settings/set_notfication_screen.dart';
import 'package:expense_tracker/Settings/set_remanider_screen.dart';
import 'package:expense_tracker/constants/used_widgets.dart';
import 'package:flutter/material.dart';


class SettingScreen extends StatelessWidget {
  static String id ="Setting Screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                ListTile(
                  title: Text('Link Financial App'),
                  trailing: Icon(Icons.arrow_forward_ios,color: usedColor,),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.grey)
                  ),
                  minVerticalPadding: 20,
                  onTap: ()=> Navigator.pushNamed(context,BankMangementPage.id),
                ),
                SizedBox(height: 15,),
                ListTile(
                  title: Text('Set Remainder'),
                  trailing: Icon(Icons.arrow_forward_ios,color: usedColor,),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Colors.grey)
                  ),
                  minVerticalPadding: 20,
              onTap: ()=> Navigator.pushNamed(context,SetRemaniderScreen.id),

                ),
                SizedBox(height: 15,),
                ListTile(
                  title: Text('Set Notfication'),
                  trailing: Icon(Icons.arrow_forward_ios,color: usedColor,),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Colors.grey)
                  ),
                  minVerticalPadding: 20,
                  onTap: ()=> Navigator.pushNamed(context,SetNotficationScreen.id)
                ),
                SizedBox(height: 15,),
                ListTile(
                  title: Text('Logout',style: TextStyle(color: usedColor),),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Colors.grey)
                  ),
                  minVerticalPadding: 20,
                    onTap: ()=> Navigator.pushNamed(context,Logout.id)
                ),
                SizedBox(height: 15,),
              ],
            ),
            ),
          ),

      )
    );
  }
}
