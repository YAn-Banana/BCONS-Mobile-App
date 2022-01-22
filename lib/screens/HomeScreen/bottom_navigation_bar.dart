import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/user_profile.dart';
import 'package:bcons_app/screens/HomeScreen/home_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarLayout extends StatefulWidget {
  const BottomNavigationBarLayout({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarLayoutState createState() =>
      _BottomNavigationBarLayoutState();
}

class _BottomNavigationBarLayoutState extends State<BottomNavigationBarLayout> {
  int currentIndex = 0;
  final tabs = [
    const HomeScreen(),
    const UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
