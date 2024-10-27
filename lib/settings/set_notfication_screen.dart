import 'package:flutter/material.dart';

import '../constants/used_widgets.dart';
class SetNotficationScreen extends StatefulWidget {
  static  String id ="SetnotficationScreen";
  const SetNotficationScreen({super.key});

  @override
  State<SetNotficationScreen> createState() => _SetNotficationScreenState();
}

class _SetNotficationScreenState extends State<SetNotficationScreen> {
  @override
  var isOn;
  void initState() {
    // TODO: implement initState
    super.initState();
    isOn = true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set Notfication"),
      ),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                Text("Turn on your notification to get updated about your expense claims",style: TextStyle(fontSize: 18)),
                SizedBox(height: 15,),
                ListTile(
                  title: Text("Push notification"),
                  trailing: Transform.scale(
                    scale: 0.5,
                    child: Switch(
                        value: isOn,
                        activeColor: Colors.white,
                        activeTrackColor: usedColor,
                        onChanged: (newValue){
                          setState(() {
                            isOn = newValue;
                          });
                        }
                    ),
                  ),
                  
                )
              ],
            )
          ),
       ),
      )
    );
  }
}
