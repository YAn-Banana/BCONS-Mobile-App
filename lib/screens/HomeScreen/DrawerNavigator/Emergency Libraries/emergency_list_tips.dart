import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/Emergency%20Libraries/accident_tips.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/Emergency%20Libraries/covid19_tips.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/Emergency%20Libraries/crime_prevention_tips.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/Emergency%20Libraries/earthquake_tips.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/Emergency%20Libraries/el_nino_tips.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/Emergency%20Libraries/fire_prevention_tips.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/Emergency%20Libraries/health_awareness.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/Emergency%20Libraries/other_emergency_tips.dart';
import 'package:bcons_app/screens/HomeScreen/home_screen.dart';
import 'package:flutter/material.dart';

import '../contacts.dart';
import '../user_profile.dart';
import 'flood_tips.dart';

class EmergencyTips extends StatefulWidget {
  const EmergencyTips({Key? key}) : super(key: key);

  @override
  State<EmergencyTips> createState() => _EmergencyTipsState();
}

class _EmergencyTipsState extends State<EmergencyTips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Emergency Tips',
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
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height + 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [Colors.black, Colors.red, Colors.black]),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        scale: 1.0,
                        image: AssetImage('assets/images/EarthquakeLogo.png'),
                      )),
                    ),
                    title: const Text(
                      'Earthquake Tips',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5,
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EarthquakeTips()));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        scale: 1.0,
                        image: AssetImage('assets/images/FireLogo.png'),
                      )),
                    ),
                    title: const Text(
                      'Fire Prevention Tips',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5,
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const FirePreventionTips()));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        scale: 1.0,
                        image: AssetImage('assets/images/CrimeLogo.png'),
                      )),
                    ),
                    title: const Text(
                      'Crime Prevention Tips',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5,
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CrimePreventionTips()));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        scale: 1.0,
                        image: AssetImage('assets/images/Health Logo.png'),
                      )),
                    ),
                    title: const Text(
                      'Health Awareness',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5,
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HealthAwareness()));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        scale: 1.0,
                        image: AssetImage('assets/images/cOVIDLOGO.png'),
                      )),
                    ),
                    title: const Text(
                      'Covid19 Tips',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5,
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Covid19Tips()));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        scale: 1.0,
                        image: AssetImage('assets/images/accidentLogo.png'),
                      )),
                    ),
                    title: const Text(
                      'Accident Preparedness',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5,
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AccidentTips()));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        scale: 1.0,
                        image: AssetImage('assets/images/FloodLogo.png'),
                      )),
                    ),
                    title: const Text(
                      'Flood Emergency Tips',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5,
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FloodTips()));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        scale: 1.0,
                        image: AssetImage('assets/images/ElNinoLogo.png'),
                      )),
                    ),
                    title: const Text(
                      'El Niño Preparedness Plan',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5,
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ElNinoTips()));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        scale: 1.0,
                        image: AssetImage('assets/images/OthersLogo.png'),
                      )),
                    ),
                    title: const Text(
                      'Other Emergency Tips',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5,
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const OtherEmergencyTips()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
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
                    title: const Icon(Icons.phone, color: Colors.black),
                    subtitle: const Text(
                      'Contact',
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
                              builder: (context) => const ContactScreen()),
                          (route) => false);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: const Icon(
                      Icons.book_outlined,
                      color: Color(0xffd90824),
                    ),
                    subtitle: const Text(
                      'Library',
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
