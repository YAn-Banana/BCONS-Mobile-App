import 'package:bcons_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class NewUserProfile extends StatefulWidget {
  const NewUserProfile({Key? key}) : super(key: key);

  @override
  _NewUserProfileState createState() => _NewUserProfileState();
}

class _NewUserProfileState extends State<NewUserProfile> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final firebase_auth.FirebaseAuth firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Profile',
          style: TextStyle(
              fontFamily: 'PoppinsBold',
              letterSpacing: 2.0,
              color: Colors.white,
              fontSize: 20.0),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: const Color(0xffcc021d),
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                color: const Color(0xffd90824),
                height: 210.0,
                width: double.infinity,
              ),
              const Positioned(
                top: 100.0,
                child: CircleAvatar(
                  radius: 87.0,
                  backgroundColor: Color(0xffcc021d),
                  child: CircleAvatar(
                    radius: 80.0,
                    backgroundColor: Color(0xffd90824),
                    backgroundImage:
                        AssetImage('assets/images/browsing_online.png'),
                  ),
                ),
              ),
              const Positioned(
                right: 30.0,
                top: 20.0,
                child: Icon(
                  Icons.edit,
                  size: 35.0,
                  color: Colors.white,
                ),
              ),
              const Positioned(
                left: 30.0,
                top: 30.0,
                child: Text(
                  'Name',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      fontFamily: 'PoppinsBold'),
                ),
              ),
              Positioned(
                left: 30.0,
                top: 50.0,
                child: Text(
                  '${loggedInUser.firstName} ${loggedInUser.middleInitial}. ${loggedInUser.lastName}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      letterSpacing: 2.0,
                      fontFamily: 'PoppinsBold'),
                ),
              ),
              const SizedBox(
                height: 220.0,
              ),
              const Positioned(
                left: 30.0,
                bottom: -110.0,
                child: Text(
                  'Mobile Number',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      fontFamily: 'PoppinsBold'),
                ),
              ),
              Positioned(
                left: 30.0,
                bottom: -135.0,
                child: Text(
                  '${loggedInUser.contactNumber}',
                  style: const TextStyle(
                      color: Color(0xffd90824),
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      letterSpacing: 2.0,
                      fontFamily: 'PoppinsBold'),
                ),
              ),
              const Positioned(
                left: 30.0,
                bottom: -180.0,
                child: Text(
                  'Email',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                      fontFamily: 'PoppinsBold'),
                ),
              ),
              Positioned(
                left: 30.0,
                bottom: -205.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${loggedInUser.email}',
                      style: const TextStyle(
                          color: Color(0xffd90824),
                          fontSize: 15.0,
                          letterSpacing: 2.0,
                          fontFamily: 'PoppinsBold'),
                    )
                  ],
                ),
              ),
              const Positioned(
                left: 30.0,
                bottom: -240.0,
                child: Text(
                  'Birthday',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                      fontFamily: 'PoppinsBold'),
                ),
              ),
              Positioned(
                left: 30.0,
                bottom: -265.0,
                child: Text(
                  '${loggedInUser.birthday}',
                  style: const TextStyle(
                      color: Color(0xffd90824),
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      letterSpacing: 2.0,
                      fontFamily: 'PoppinsBold'),
                ),
              ),
              const Positioned(
                left: 30.0,
                bottom: -310.0,
                child: Text(
                  'Address',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                      fontFamily: 'PoppinsBold'),
                ),
              ),
              Positioned(
                left: 30.0,
                bottom: -335.0,
                child: Text(
                  '${loggedInUser.brgy}',
                  style: const TextStyle(
                      color: Color(0xffd90824),
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      letterSpacing: 2.0,
                      fontFamily: 'PoppinsBold'),
                ),
              ),
              Positioned(
                left: 30.0,
                bottom: -355.0,
                child: Text(
                  '${loggedInUser.municipality}, ${loggedInUser.province}',
                  style: const TextStyle(
                      color: Color(0xffd90824),
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      letterSpacing: 2.0,
                      fontFamily: 'PoppinsBold'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
