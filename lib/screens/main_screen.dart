import 'package:flutter/material.dart';
import 'package:expense_tracker/constants/used_widgets.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/data/report.dart';
import 'package:expense_tracker/Settings/settings_screen.dart';
import 'package:expense_tracker/screens/home_screen.dart';
import 'package:expense_tracker/screens/take_name_of_report_screen.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static String id ="Main Screen";
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Function to handle switching between tabs
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final reportModel = Provider.of<ReportModelView>(context);

    final List<Widget> _screens = [
      HomeScreen(),
      TakeNameOfReport(),
      SettingScreen(),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Expense Tracker')),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: usedColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),

            label: 'Create Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle,color:Colors.grey,size: 30,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
