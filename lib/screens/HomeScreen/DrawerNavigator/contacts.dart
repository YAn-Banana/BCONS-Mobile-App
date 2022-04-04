import 'package:bcons_app/screens/HomeScreen/home_screen.dart';
import 'package:flutter/material.dart';

import 'Emergency Libraries/emergency_list_tips.dart';
import 'user_profile.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact List',
          style: TextStyle(
              fontFamily: 'PoppinsBold',
              letterSpacing: 2.0,
              color: Colors.white,
              fontSize: 20.0),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: const Color(0xffcc021d),
        leading: InkWell(
            child: const Icon(
              Icons.arrow_back,
            ),
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false)),
      ),
      persistentFooterButtons: [
        SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: const Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    subtitle: const Text(
                      'Home',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          letterSpacing: 1.5,
                          fontFamily: 'PoppinsRegular'),
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                          (route) => false);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: const Icon(Icons.person, color: Colors.black),
                    subtitle: const Text(
                      'Person',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          letterSpacing: 1.5,
                          fontFamily: 'PoppinsRegular'),
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserProfile()),
                          (route) => false);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: const Icon(
                      Icons.phone,
                      color: Color(0xffd90824),
                    ),
                    subtitle: const Text(
                      'Contact',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xffd90824),
                          fontSize: 13.0,
                          letterSpacing: 1.5,
                          fontFamily: 'PoppinsRegular'),
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactScreen()),
                          (route) => false);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: const Icon(Icons.book_outlined),
                    subtitle: const Text(
                      'Library',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          letterSpacing: 1.5,
                          fontFamily: 'PoppinsRegular'),
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EmergencyTips()),
                          (route) => false);
                    },
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
