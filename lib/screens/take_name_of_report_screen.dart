import 'package:expense_tracker/screens/report_main_form_screen.dart';
import 'package:flutter/material.dart';
import '../constants/used_widgets.dart';


class TakeNameOfReport extends StatefulWidget {
  static String id ="Take Name Of Report";
  @override
  State<TakeNameOfReport> createState() => _TakeNameOfReportState();
}

class _TakeNameOfReportState extends State<TakeNameOfReport> {
  final _reportNameController = TextEditingController();

  @override
  void dispose() {
    _reportNameController.dispose();
    super.dispose();
  }

  void _addExpense() {
    final reportName = _reportNameController.text;

    _reportNameController.clear();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateReportScreen(
          reportName: reportName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height/10,),
              Text(
                "Report Name",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _reportNameController,
                decoration: InputDecoration(
                  hintText: "Enter Report Name",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
                  ),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                cursorColor: usedColor,
              ),
              SizedBox(height: 30),
              OutlinedButton(
                onPressed: _addExpense,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: usedColor),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  minimumSize: Size(double.infinity, 48),
                ),
                child: Text("Add Expense",style: TextStyle(color: usedColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
