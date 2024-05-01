import 'package:flutter/material.dart';
import 'package:tracker/helpers/colors_manager.dart';
import 'categories_page.dart';
import 'progress_page.dart';
import 'home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List pages = [const Home(), Categories(), const Progress()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        showSelectedLabels: false,
        selectedItemColor: AppColors.primary,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(label: "", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "", icon: Icon(Icons.category)),
          BottomNavigationBarItem(label: "", icon: Icon(Icons.bar_chart)),
        ],
      ),
      body: pages.elementAt(_selectedIndex),
    );
  }
}
