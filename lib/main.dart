import 'package:expense_tracker/Settings/logout_screen.dart';
import 'package:expense_tracker/screens/main_screen.dart';
import 'package:expense_tracker/screens/login_screen.dart';
import 'package:expense_tracker/screens/report_details_screen.dart';
import 'package:expense_tracker/screens/report_main_form_screen.dart';
import 'package:expense_tracker/screens/take_name_of_report_screen.dart';
import 'package:flutter/material.dart';
import 'Settings/FinanicalDetails/bank_management_page.dart';
import 'Settings/FinanicalDetails/display_all_banks_screen.dart';
import 'Settings/set_notfication_screen.dart';
import 'Settings/set_remanider_screen.dart';
import 'data/report.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'package:expense_tracker/Settings/settings_screen.dart';
import 'data/bank_data.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => BankModelView()),
      ChangeNotifierProvider(create: (_) => ReportModelView()),
    ],
    child: MyApp(),
  ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        MainScreen.id :(context) => MainScreen(),
        HomeScreen.id: (context)=> HomeScreen(),
        TakeNameOfReport.id: (context)=> TakeNameOfReport(),
        CreateReportScreen.id:(context)=> CreateReportScreen(reportName: '',),
        ReportDetailsScreen.id:(context)=> ReportDetailsScreen(report: Report(report_name: "", name: "", amount: 0, date: "", description: "", category: "", submitted: false)),

        SettingScreen.id: (context)=> SettingScreen(),
        BankMangementPage.id: (context)=> BankMangementPage(),
        DisplayBanks.id: (context)=> DisplayBanks(),
        SetRemaniderScreen.id : (context)=> SetRemaniderScreen(),
        SetNotficationScreen.id : (context)=> SetNotficationScreen(),
        Logout.id : (context)=> Logout(),
      },
      home: SplashScreen(),
    );
  }
}
