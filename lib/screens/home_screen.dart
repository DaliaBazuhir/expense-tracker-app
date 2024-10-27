import 'package:expense_tracker/screens/report_details_screen.dart';
import 'package:expense_tracker/screens/take_name_of_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/constants/used_widgets.dart';
import 'package:expense_tracker/data/report.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static String id ="Home Screen";
  @override
  Widget build(BuildContext context) {
    final reportModel = Provider.of<ReportModelView>(context);
    var countOfSubmitReports = reportModel.countSubmittedReports();
    var countOfUnsubmitReports = reportModel.countUnSubmittedReports();
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    home_screen_Card(
                      cardNumber: "${countOfUnsubmitReports}",
                      cardText: "Expense Report created",
                    ),
                    SizedBox(width: 10),
                    home_screen_Card(
                      // cardNumber: "${reportModel.submittedReports.length}",

                      cardNumber: "${countOfSubmitReports}",
                      cardText: "Expense Report submitted",
                    ),
                  ],
                ),
                SizedBox(height: 35),
                ///////
                // if (reportModel.submittedReports.isEmpty && reportModel.unsubmittedReports.isEmpty)
                if(reportModel.reports_list.isEmpty)
                  No_Report(context) ,
                Reports_List_WithDelete(reportModel.reports_list, reportModel),
                // Reports_List_WithDelete(reportModel.unsubmittedReports,reportModel ) ,
                // Reports_List_WithDelete(reportModel.submittedReports,reportModel),
                // SizedBox(height: 15,),
                SizedBox(height: 15,),
              ],
            ),
          ),
        ),

    );
  }
}

Widget Reports_List_WithDelete(List<Report> reportList, ReportModelView model) {
var selectedInd;
  return
    Expanded(
      child:  ListView.builder(
      itemCount: reportList.length,
      itemBuilder: (context, index) {
        final report = reportList[index];
        return Dismissible(
          key: Key(report.name),
          background: Container(
            color: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: AlignmentDirectional.topStart,
            child: Icon(Icons.delete, color: Colors.white),
          ),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            // Remove the bank from the list
            Provider.of<ReportModelView>(context, listen: false).removeReport(report);

            // Show a snackbar to indicate removal
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${report.name} removed')),
            );
          },
       child:  Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
              child: GestureDetector(
                onTap: () async {
                  if (!report.submitted) {
                    final updatedReport = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportDetailsScreen(report: report),
                      ),
                    );

                    if (updatedReport != null) {
                      // Remove the old report from the appropriate list
                      model.removeReport(report);
                      // Add the updated report to the correct list (submitted or unsubmitted)
                      model.addReport(updatedReport);
                    }
                  }
                },
                child: ListTile(
                  title: Text(reportList[index].name),
                  subtitle: Text(reportList[index].date),
                  trailing: reportList[index].submitted
                      ? Text("") : Text(
                    "Not submitted",
                    style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,backgroundColor: Colors.yellow.withOpacity(0.5)),
                  ),
                  isThreeLine: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            )
        );
      },
    ),
    );
}


Widget No_Report(BuildContext context) {
  return Column(
    crossAxisAlignment:  CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "No expense report found!",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      SizedBox(height: 15),
      Text(
        "Create an expense report to get started",
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 25),
      UsedGradientButton(
        textButton: "Create Expense Report",
        onPressedFunction:
        ()=> Navigator.pushNamed(context,TakeNameOfReport.id)
  ),
  ]

);
}

