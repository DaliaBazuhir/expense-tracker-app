import 'package:flutter/material.dart';
import 'package:expense_tracker/constants/used_widgets.dart';
import 'package:expense_tracker/data/report.dart';

class ReportDetailsScreen extends StatefulWidget {
  Report report;

  static String id = "ReportDetailsScreen";
  ReportDetailsScreen({required this.report,});

  @override
  State<ReportDetailsScreen> createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  late TextEditingController reportNameController;
  late TextEditingController nameController;
  late TextEditingController amountController;
  late TextEditingController descriptionController;
  late String dropDown;
  late bool isSubmitted;
  @override
  void initState() {
    super.initState();
    reportNameController = TextEditingController(text: widget.report.report_name);
    nameController = TextEditingController(text: widget.report.name);
    amountController = TextEditingController(text: widget.report.amount.toString());
    descriptionController = TextEditingController(text: widget.report.description);
    isSubmitted = widget.report.submitted;
  }
  void saveReport() {
    // Update the report with new data
    setState(() {
      widget.report .report_name = reportNameController.text;
      widget.report.name = nameController.text;
      widget.report.amount = double.tryParse(amountController.text) ?? widget.report.amount;
      widget.report.description = descriptionController.text;
      widget.report.submitted = isSubmitted;
    });

    // Pop the screen with updated report data
    Navigator.pop(context, widget.report);
  }

  void submitReport(){

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
      Padding(padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  controller: reportNameController,
                  cursorColor: usedColor,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
                    ),
                    labelText: 'Report Name',
                    labelStyle: TextStyle(color:usedColor),
                    focusColor: usedColor,
                  )
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
                  ),
                  labelText: 'Name',
                  labelStyle: TextStyle(color:usedColor),
                  focusColor: usedColor,
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: amountController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
                  ),
                  labelText: 'Amount',
                  labelStyle: TextStyle(color:usedColor),
                  focusColor: usedColor,
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
                  ),
                  labelText: 'Description',
                  labelStyle: TextStyle(color:usedColor),
                  focusColor: usedColor,
                ),
              ),
              SizedBox(height: 15,),
              OutlinedButton(
                  onPressed: (){
                    saveReport();
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: usedColor),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    minimumSize: Size(100, 48),
                  ),
                  child: Text("Add Expsense",style: TextStyle(color: usedColor),)
              ),

              SizedBox(height: 15,),
              UsedGradientButton(
                  textButton: "Submit Expense Report",
                  onPressedFunction: (){
                    setState(() {
                      isSubmitted = true;
                      saveReport();
                    });
                  }
              ),
            ],
          )
      )
      ),
    );
  }
}

