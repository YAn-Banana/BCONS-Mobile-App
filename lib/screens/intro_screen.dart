import 'package:bcons_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Online Information',
            body: 'Alert Everyone with a Tap',
            image: buildImage('assets/images/browsing_online.png'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
              title: 'Location Review',
              body: 'Send your Location Instantly',
              image: buildImage('assets/images/location_review.png'),
              decoration: getPageDecoration()),
          PageViewModel(
            title: 'Browsing Online',
            body: 'Know the Things to do during Emergencies',
            image: buildImage('assets/images/online_information.png'),
            decoration: getPageDecoration(),
          )
        ],
        done: const Text('Done',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 1.5,
              fontFamily: 'PoppinsRegular',
            )),
        onDone: () => goHome(context),
        skip: const Text(
          'Skip',
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 1.5,
              fontFamily: 'PoppinsRegular'),
        ),
        next: const Icon(Icons.arrow_forward, color: Colors.black),
        showSkipButton: true,
        showDoneButton: true,
        showNextButton: true,
        dotsDecorator: getDotsDecorator(),
        nextFlex: 0,
        skipFlex: 0,
      ),
    );
  }

  Widget buildImage(String path) => Center(
          child: Image.asset(
        path,
        width: 300,
      ));

  PageDecoration getPageDecoration() => PageDecoration(
      titleTextStyle: const TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'PoppinsBold',
          letterSpacing: 2.0),
      bodyTextStyle: const TextStyle(
          fontSize: 20.0, letterSpacing: 1.5, fontFamily: 'PoppinsRegular'),
      descriptionPadding: const EdgeInsets.all(5.0).copyWith(bottom: 0),
      imagePadding: const EdgeInsets.all(5.0),
      pageColor: Colors.white);

  DotsDecorator getDotsDecorator() => const DotsDecorator(
      activeColor: Colors.red,
      size: Size.square(10.0),
      activeSize: Size.square(20.0));
}

void goHome(context) => Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => const LoginScreen()));
