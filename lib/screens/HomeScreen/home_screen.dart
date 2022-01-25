import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/drawer_layout.dart';
import 'package:bcons_app/screens/HomeScreen/report_style.dart';
import 'package:bcons_app/screens/login_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              onPressed: () {},
              icon: const Icon(Icons.notifications),
              color: Colors.white,
              iconSize: 30.0,
            )
          ],
        ),
        drawer: const DrawerLayout(),
        body: Column(
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
                        ContainerList("ShortnessofBreath(1).png"),
                        ContainerList("ShortnessofBreath(2).png"),
                        ContainerList("ShortnessofBreath(3).png"),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                height: 260.0,
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
                                  fontSize: 35.0,
                                  letterSpacing: 1.5,
                                  fontFamily: 'PoppinsBold'),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ));
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
