import 'package:expense_tracker/constants/used_widgets.dart';
import 'package:flutter/material.dart';

class SetRemaniderScreen extends StatefulWidget {
  static  String id ="SetremaniderScreen";
  const SetRemaniderScreen({super.key});

  @override
  State<SetRemaniderScreen> createState() => _SetRemaniderScreenState();
}

class _SetRemaniderScreenState extends State<SetRemaniderScreen> {
  List<Remainder> userRemainders = [
    Remainder(remaninerTitle: "Daily reminder", isActive: true),
    Remainder(remaninerTitle: "Weekly reminder", isActive: true),
    Remainder(remaninerTitle: "Monthly reminder", isActive: true),
  ];

  var customReminderDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set Remainder"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Text("Set reminder to input your expenses on a regular basis", style: TextStyle(fontSize: 18)),
                SizedBox(height: 15),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: userRemainders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(5),
                        child: ListTile(
                          title: Text(userRemainders[index].remaninerTitle),
                          trailing: Transform.scale(
                            scale: 0.5,
                            child: Switch(
                              value: userRemainders[index].isActive,
                              activeColor: Colors.white,
                              activeTrackColor: usedColor, // Replace with your usedColor variable
                              inactiveThumbColor: Colors.white,
                              onChanged: (newValue) {
                                setState(() {
                                  userRemainders[index].isActive = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    _showCustomReminderDialog(context);
                  },
                  child: Text("Set Customise Reminder", style: TextStyle(color: usedColor, fontWeight: FontWeight.w800)), // Replace with your usedColor variable
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCustomReminderDialog(BuildContext context) {
    TextEditingController dateController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child:  Container(
            padding: EdgeInsets.all(20.0),
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Set Customised Reminder',textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
                SizedBox(height: 15,),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(hintText: 'Select your preferred date',
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
                UsedGradientButton(
                  textButton: 'Save', onPressedFunction: (){
                  setState(() {
                    customReminderDate = dateController.text;
                    userRemainders.add(Remainder(remaninerTitle: customReminderDate, isActive: true)); // Add new reminder directly
                  });
                  Navigator.of(context).pop();
                },)
            ],
            ),
          )
        );
      },
    );
  }
}

class Remainder {
  final String remaninerTitle;
  bool isActive;
  Remainder({required this.remaninerTitle, this.isActive = true});
}
