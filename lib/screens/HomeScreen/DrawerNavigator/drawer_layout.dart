//import 'dart:html';

import 'package:bcons_app/model/user_model.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/ChatRoom/chat_room.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/HistoryOfReports/history.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/contact_us.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/contacts.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/user_profile.dart';
import 'package:bcons_app/screens/HomeScreen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:shared_preferences/shared_preferences.dart';
import '../../login_screen.dart';
import 'about_bcons.dart';

class DrawerLayout extends StatefulWidget {
  const DrawerLayout({Key? key}) : super(key: key);

  @override
  _DrawerLayoutState createState() => _DrawerLayoutState();
}

class _DrawerLayoutState extends State<DrawerLayout> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final firebase_auth.FirebaseAuth firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

  Future<void> logout(BuildContext context) async {
    await firebaseAuth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('email');
    sharedPreferences.remove('contact');
  }

  //Navigate to User Profile Screen
  void userProfile(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const UserProfile()));
  }

  void contactUs(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ContactUs()));
  }

  //Navigate to Contacts List Screen
  void contactScreen(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ContactScreen()));
  }

  void historyReportScreen(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const HistoryOfReports()));
  }

  void bconsScreen(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AboutBcons()));
  }

  void chatRoom(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ChatRooms()));
  }

  void home(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                padding: const EdgeInsets.fromLTRB(0.0, 40.0, 10.0, 0.0),
                decoration: const BoxDecoration(
                  color: Color(0xffcc021d),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    loggedInUser.image == null
                        ? Container(
                            height: 120.0,
                            width: 120.0,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/profile.png'),
                                    fit: BoxFit.cover)),
                          )
                        : Container(
                            height: 120.0,
                            width: 120.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                        NetworkImage('${loggedInUser.image}'),
                                    fit: BoxFit.cover)),
                          ),
                    const SizedBox(width: 5.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        loggedInUser.middleInitial!.isEmpty
                            ? Text('${loggedInUser.firstName}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    letterSpacing: 1.5,
                                    fontFamily: 'PoppinsRegular'))
                            : Text(
                                '${loggedInUser.firstName} ${loggedInUser.middleInitial}.',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    letterSpacing: 1.5,
                                    fontFamily: 'PoppinsRegular')),
                        const SizedBox(
                          height: 1.5,
                        ),
                        Text('${loggedInUser.lastName}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                letterSpacing: 1.5,
                                fontFamily: 'PoppinsRegular')),
                        const SizedBox(
                          height: 1.5,
                        ),
                        Text('+63${loggedInUser.contactNumber}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                letterSpacing: 1.5,
                                fontFamily: 'PoppinsRegular')),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 200,
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 0.0, 0.0),
                decoration: const BoxDecoration(
                  color: Color(0xffd90824),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.home,
                        color: Colors.grey,
                      ),
                      title: const Text(
                        'Home',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PoppinsRegular',
                          letterSpacing: 1.5,
                          fontSize: 14.0,
                        ),
                      ),
                      onTap: () {
                        home(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.message,
                        color: Colors.grey,
                      ),
                      title: const Text(
                        'Messages',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PoppinsRegular',
                          letterSpacing: 1.5,
                          fontSize: 14.0,
                        ),
                      ),
                      onTap: () {
                        chatRoom(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.history,
                        color: Colors.grey,
                      ),
                      title: const Text(
                        'History',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PoppinsRegular',
                          letterSpacing: 1.5,
                          fontSize: 14.0,
                        ),
                      ),
                      onTap: () {
                        historyReportScreen(context);
                      },
                    ),
                    /* ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      title: const Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PoppinsRegular',
                          letterSpacing: 1.5,
                          fontSize: 14.0,
                        ),
                      ),
                      onTap: () {
                        userProfile(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.phone,
                        color: Colors.grey,
                      ),
                      title: const Text(
                        'Contacts',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PoppinsRegular',
                          letterSpacing: 1.5,
                          fontSize: 14.0,
                        ),
                      ),
                      onTap: () {
                        contactScreen(context);
                      },
                    ),
                    
                    ListTile(
                      leading: const Icon(
                        Icons.report,
                        color: Colors.grey,
                      ),
                      title: const Text(
                        'Report to ERT',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PoppinsRegular',
                          letterSpacing: 1.5,
                          fontSize: 14.0,
                        ),
                      ),
                      onTap: () {},
                    ),*/
                    ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.grey,
                      ),
                      title: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PoppinsRegular',
                          letterSpacing: 1.5,
                          fontSize: 14.0,
                        ),
                      ),
                      onTap: () async {
                        logout(context);
                        final SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.remove('email');
                        sharedPreferences.remove('contacNumber');
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                      title: const Text(
                        'Contact Us',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PoppinsRegular',
                          letterSpacing: 1.5,
                          fontSize: 14.0,
                        ),
                      ),
                      onTap: () {
                        contactUs(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.info,
                        color: Colors.grey,
                      ),
                      title: const Text(
                        'About BCONS',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PoppinsRegular',
                          letterSpacing: 1.5,
                          fontSize: 14.0,
                        ),
                      ),
                      onTap: () {
                        bconsScreen(context);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
