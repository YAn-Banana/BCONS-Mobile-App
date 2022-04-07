import 'package:bcons_app/PracticeFunctions/TypeOfReport/notifications.dart';
import 'package:bcons_app/model/user_model.dart';

import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/Libraries/emergency_libraries.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/contacts.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/drawer_layout.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/user_profile.dart';
import 'package:bcons_app/screens/HomeScreen/report_style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final firebase_auth.FirebaseAuth firebaseAuth =
    firebase_auth.FirebaseAuth.instance;

//Navigate to User Profile Screen
void chooseReportStyle(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const ChooseReport()));
}

class _HomeScreenState extends State<HomeScreen> {
  String? liveLatitude;
  String? liveLongitude;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void updateUserLiveLongAndLat() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebase_auth.User? user = firebaseAuth.currentUser;
    UserModel userModel = UserModel();
    Position position = await _determinePosition();
    setState(() {
      liveLatitude = '${position.latitude}';
      liveLongitude = '${position.longitude}';
    });

    userModel.uid = user!.uid;
    try {
      await firebaseFirestore.collection('Users').doc(user.uid).update(
          {'liveLatitude': liveLatitude, 'liveLongitude': liveLongitude});
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    updateUserLiveLongAndLat();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HOME',
          style: TextStyle(
              fontFamily: 'PoppinsBold',
              letterSpacing: 2.0,
              color: Colors.white,
              fontSize: 20.0),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: const Color(0xffcc021d),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const Notifications())));
            },
            icon: const Icon(Icons.notifications),
            color: Colors.white,
            iconSize: 30.0,
          )
        ],
      ),
      drawer: const DrawerLayout(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                Container(
                  height: 325.0,
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 30.0),
                  color: const Color(0xffd90824),
                  child: Center(
                    child: CarouselSlider(
                      options: CarouselOptions(
                          height: 250.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          scrollDirection: Axis.horizontal,
                          aspectRatio: 16 / 9,
                          autoPlayAnimationDuration:
                              const Duration(microseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayInterval: const Duration(seconds: 10),
                          viewportFraction: 1.2),
                      items: [
                        ContainerList("Covid(1).png"),
                        ContainerList("Covid(2).png"),
                        ContainerList("Covid(3).png"),
                        ContainerList("Covid(4).png"),
                        ContainerList("Covid(5).png"),
                        ContainerList("Covid(6).png"),
                        ContainerList("ShortnessofBreath(1).png"),
                        ContainerList("ShortnessofBreath(2).png"),
                        ContainerList("ShortnessofBreath(3).png"),
                        ContainerList("seizure(1).png"),
                        ContainerList("seizure(2).png"),
                        ContainerList("severe_bleeding.png"),
                        ContainerList("coping_with_traumatic_stress.png"),
                        ContainerList("sexual_violence_prevention.png"),
                        ContainerList("PhysicalInjuries.png"),
                        ContainerList("HeadinjuryTips.png"),
                        ContainerList("MentalHealth.png"),
                        ContainerList("ChestPainPrevention.png"),
                        ContainerList("ChestPainPrevention.png"),
                        ContainerList("flood(1).png"),
                        ContainerList("flood(2).png"),
                        ContainerList("flood(3).png"),
                        ContainerList("flood(4).png"),
                        ContainerList("beforeEq.png"),
                        ContainerList("duringEq.png"),
                        ContainerList("afterEq.png"),
                        ContainerList("earthquake_tips(1).png"),
                        ContainerList("beforeFire.png"),
                        ContainerList("duringFire.png"),
                        ContainerList("afterFire.png"),
                        ContainerList("el_nino(1).png"),
                        ContainerList("el_nino(2).png"),
                        ContainerList("el_nino(3).png"),
                        ContainerList("storm.png"),
                        ContainerList("CrimeRobbery(1).png"),
                        ContainerList("CrimeRobbery(2).png"),
                        ContainerList("CrimeTheft(1).png"),
                        ContainerList("CrimeTheft(2).png"),
                        ContainerList("AnimalBite(2).png"),
                        ContainerList("AnimalBite(1).png"),
                        ContainerList("animalattack.png"),
                        ContainerList("Drowning.png"),
                        ContainerList("TrafficAcc(1).png"),
                        ContainerList("TrafficAcc(2).png"),
                        ContainerList("Bombing.png"),
                        ContainerList("Chemical_Hazard.png"),
                        ContainerList("Radiation.png"),
                        ContainerList("Electrical.png"),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: 280.0,
                    width: double.infinity,
                    padding: const EdgeInsets.all(30.0),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/google-maps.jpg'),
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              chooseReportStyle(context);
                            },
                            child: Container(
                              height: 150.0,
                              width: 150.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffd90824),
                              ),
                              child: const Center(
                                child: Text(
                                  'REPORT',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      letterSpacing: 1.5,
                                      fontFamily: 'PoppinsBold'),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: const Icon(
                      Icons.home,
                      color: Color(0xffd90824),
                    ),
                    subtitle: const Text(
                      'Home',
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
                              builder: (context) => const HomeScreen()),
                          (route) => false);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: const Icon(Icons.person),
                    subtitle: const Text(
                      'Profile',
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
                    title: const Icon(Icons.phone),
                    subtitle: const Text(
                      'Contacts',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.0,
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
                              builder: (context) => const Libraries()),
                          (route) => false);
                    },
                  ),
                ),
              ],
            ))
      ],
    );
  }

  Widget ContainerList(String imageName) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
              image: AssetImage('assets/images/$imageName'),
              fit: BoxFit.contain)),
    );
  }
}
