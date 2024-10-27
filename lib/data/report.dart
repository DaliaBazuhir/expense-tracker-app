import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';

// Report Model
class Report {
  late String report_name;
  late String name;
  late double amount;
  late String date;
  late String description;
  late String category;
  late double? vat;
  late File? image;
   bool submitted = false;

  Report({
    required this.report_name,
    required this.name,
    required this.amount,
    required this.date,
    required this.description,
     required this.category,
    this.vat,
    this.image,
    required this.submitted,
  });
}



class ReportModelView extends ChangeNotifier {
  // List<Report> submittedReports = [
  // ];
  // List<Report> unsubmittedReports = [
  // ];

  List<Report>reports_list = [
  ];
  void addReport(Report report) {
    // if (report.submitted) {
    //   submittedReports.add(report);
    // } else {
    //   unsubmittedReports.add(report);
    // }
    reports_list.add(report);
    notifyListeners();
  }

  void removeReport(Report report) {
    // if(report.submitted){
    //   submittedReports.remove(report);
    // }else{
    //   unsubmittedReports.remove(report);
    // }
    reports_list.remove(report);
    notifyListeners();
  }
  int countSubmittedReports() {

    return reports_list.where((report) => report.submitted == true).length;
  }
  int countUnSubmittedReports() {
    return reports_list.where((report) => report.submitted == false).length;
  }
  // Report? retrieved_Report;
  // Report retrieve_unReport(int index){
  //   retrieved_Report =  unsubmittedReports[index];
  //   notifyListeners();
  //   return retrieved_Report!;
  // }
  // This method can be expanded for editing reports
  // void editReport(Report report, int index, {required bool isSubmitted}) {
  //   if (isSubmitted) {
  //     submittedReports[index] = report;
  //   } else {
  //     unsubmittedReports[index] = report;
  //   }
  //   notifyListeners();
  // }
}
