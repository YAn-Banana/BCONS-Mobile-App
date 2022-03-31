import 'package:bcons_app/PracticeFunctions/TypeOfReport/notifications.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/Emergency%20Libraries/emergency_list_tips.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/contacts.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/drawer_layout.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/user_profile.dart';
import 'package:bcons_app/screens/HomeScreen/report_style.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';

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
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: 343.0,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 30.0),
                color: const Color(0xffd90824),
                child: ListView(
                  children: [
                    Center(
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
                          ContainerList("CrimeRobbery(1).png"),
                          ContainerList("CrimeRobbery(2).png"),
                          ContainerList("CrimeTheft(1).png"),
                          ContainerList("CrimeTheft(2).png"),
                          ContainerList("EarthquakeTips.png"),
                          ContainerList("FirePreparedness.png"),
                          ContainerList("HeadinjuryTips.png"),
                          ContainerList("MentalHealth.png"),
                          ContainerList("PhysicalInjuries.png"),
                          ContainerList("ChestPain.png"),
                          ContainerList("AnimalBite(1).png"),
                          ContainerList("AnimalBite(1).png"),
                          ContainerList("animalattack.png"),
                          ContainerList("Bombing.png"),
                          ContainerList("Chemical_Hazard.png"),
                          ContainerList("Drowning.png"),
                          ContainerList("earthquake_tips(1).png"),
                          ContainerList("Electrical.png"),
                          ContainerList("seizure(1).png"),
                          ContainerList("seizure(2).png"),
                          ContainerList("severe_bleeding.png"),
                          ContainerList("storm.png"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  height: 200.0,
                  width: double.infinity,
                  padding: const EdgeInsets.all(30.0),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/google-maps.jpg'),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            chooseReportStyle(context);
                          },
                          child: Container(
                            height: 200.0,
                            width: 200.0,
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
                        )
                      ],
                    ),
                  )),
              SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          selectedTileColor: Colors.cyan,
                          title: const Icon(Icons.home),
                          subtitle: const Text(
                            'Home',
                            textAlign: TextAlign.center,
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
                            'Person',
                            textAlign: TextAlign.center,
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
                          subtitle: const Text('Contact',
                              textAlign: TextAlign.center),
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ContactScreen()),
                                (route) => false);
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ListTile(
                          title: const Icon(Icons.book_outlined),
                          subtitle: const Text('Library',
                              textAlign: TextAlign.center),
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EmergencyTips()),
                                (route) => false);
                          },
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ],
      ),
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
