import 'package:bcons_app/model/user_model.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/drawer_layout.dart';
import 'package:bcons_app/screens/HomeScreen/bottom_navigation_bar.dart';
import 'package:bcons_app/screens/HomeScreen/report_style.dart';
import 'package:bcons_app/screens/login_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

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
          backgroundColor: Colors.redAccent[700],
        ),
        drawer: const DrawerLayout(),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 405.0,
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 30.0),
                  color: Colors.redAccent[700],
                  child: ListView(
                    children: [
                      Center(
                        child: CarouselSlider(
                          options: CarouselOptions(
                              height: 300.0,
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
                            Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: const DecorationImage(
                                      image:
                                          AssetImage('assets/images/theft.png'),
                                      fit: BoxFit.contain)),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/robbery.png'),
                                      fit: BoxFit.contain)),
                            ),
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
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent[700],
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
            ),
          ),
        ));
  }
}
