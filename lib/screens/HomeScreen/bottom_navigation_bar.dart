import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/contacts.dart';

import 'package:bcons_app/screens/HomeScreen/home_screen.dart';
import 'package:flutter/material.dart';

import 'DrawerNavigator/user_profile.dart';

class BottomNavigationBarLayout extends StatefulWidget {
  const BottomNavigationBarLayout({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarLayoutState createState() =>
      _BottomNavigationBarLayoutState();
}

class _BottomNavigationBarLayoutState extends State<BottomNavigationBarLayout> {
  int currentIndex = 0;
  List<Widget> widgetSelections = <Widget>[
    const HomeScreen(),
    const UserProfile(),
    const ContactScreen()
  ];
  void onItemTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: widgetSelections,
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Contacts')
          ],
          onTap: onItemTap),
    );
  }
}
