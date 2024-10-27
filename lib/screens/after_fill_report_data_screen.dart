import 'package:expense_tracker/constants/used_widgets.dart';
import 'package:expense_tracker/data/report.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';


class DecsideSubmitOrNot extends StatefulWidget {

  final Report report;
  final reportName;
  DecsideSubmitOrNot({required this.reportName,required this.report});

  @override
  State<DecsideSubmitOrNot> createState() => _DecsideSubmitOrNotState();
}

class _DecsideSubmitOrNotState extends State<DecsideSubmitOrNot> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height/15,),
              Text("Report Name   ${widget.reportName}"),
              SizedBox(height: 30,),
              Divider(),
              SizedBox(height: 15,),

               Row(
                children: [
                  Text("Total Amount:",style: TextStyle(fontWeight: FontWeight.w600),),
                  SizedBox(width: 20,),
                  Text("${widget.report.amount+widget.report.vat!} GBP"),
                ],
              ),
              SizedBox(height: 15,),
              if  (widget.report.image!= null)
                ListTile(
                  leading: Image.file(widget.report.image!, height: 100, width: 50),
                  title:  Text(widget.report.name),
                  subtitle: Text(widget.report.date),
                ),
              SizedBox(height: 15,),
                  OutlinedButton(
                  onPressed: (){
                   Provider.of<ReportModelView>(context, listen: false).addReport(widget.report);
                   Navigator.popUntil(context, (route) {
                     if (route.settings.name == MainScreen.id) {
                       return true;
                     }
                     return false;
                   });

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
                    widget.report.submitted = true;
                    Provider.of<ReportModelView>(context, listen: false).addReport(widget.report);
                      Navigator.popUntil(context, (route) {
                      if (route.settings.name == MainScreen.id) {
                      return true;
                      }
                      return false;
                      });
                  }
              ),
            ],



          )
       ,),
      ),
    );
  }
}
