import 'package:bcons_app/model/user_model.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/drawer_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
      drawer: const DrawerLayout(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            /*gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [Colors.black, Colors.red, Colors.black],
          ),*/
            color: Colors.grey[300]),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 150.0,
                      width: 180.0,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/BCONS_screen_.icon.png'),
                              fit: BoxFit.cover)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: const BorderSide(
                                  width: 1.0, color: Colors.redAccent),
                            ),
                            fixedSize: const Size(100.0, 30.0),
                            primary: const Color(0xffd90824),
                          ),
                          child: const Text(
                            'Upload',
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                                letterSpacing: 1.5,
                                fontFamily: 'PoppinsRegular'),
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        InkWell(
                          child: const Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 30.0,
                          ),
                          onTap: () {},
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              const Divider(
                height: 5.0,
                color: Colors.black,
                thickness: 2.0,
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                'Name',
                style: TextStyle(
                    color: Colors.redAccent[700],
                    fontSize: 15.0,
                    letterSpacing: 2.0,
                    fontFamily: 'PoppinsRegular'),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Text(
                '${loggedInUser.firstName} ${loggedInUser.middleInitial}. ${loggedInUser.lastName}',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    letterSpacing: 2.0,
                    fontFamily: 'PoppinsBold'),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'Contact Number',
                style: TextStyle(
                    color: Colors.redAccent[700],
                    fontSize: 15.0,
                    letterSpacing: 2.0),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Text(
                '${loggedInUser.contactNumber}',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    letterSpacing: 2.0,
                    fontFamily: 'PoppinsBold'),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'Email',
                style: TextStyle(
                    color: Colors.redAccent[700],
                    fontSize: 15.0,
                    letterSpacing: 2.0,
                    fontFamily: 'PoppinsRegular'),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.email,
                    color: Colors.black,
                    size: 20.0,
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    '${loggedInUser.email}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsBold'),
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              Text(
                'Birthday',
                style: TextStyle(
                    color: Colors.redAccent[700],
                    fontSize: 15.0,
                    letterSpacing: 2.0,
                    fontFamily: 'PoppinsRegular'),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Text(
                '${loggedInUser.birthday}',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    letterSpacing: 2.0,
                    fontFamily: 'PoppinsBold'),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Address',
                style: TextStyle(
                    color: Colors.redAccent[700],
                    fontSize: 15.0,
                    letterSpacing: 2.0,
                    fontFamily: 'PoppinsRegular'),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Text(
                '${loggedInUser.brgy}',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    letterSpacing: 2.0,
                    fontFamily: 'PoppinsBold'),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Text(
                '${loggedInUser.municipality}, ${loggedInUser.province}',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    letterSpacing: 2.0,
                    fontFamily: 'PoppinsBold'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
