import 'dart:async';
import 'dart:ffi';
import 'package:bcons_app/screens/HomeScreen/home_screen.dart';
import 'package:bcons_app/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? finalEmail;
  String? finalContactNumber;

  @override
  void initState() {
    super.initState();

    // After Validation, if there is an existing account or an instance that comes from the shared preferences, user will navigate immediately to the Home Screen
    // otherwise, user will navigate to the Log In Screen
    getValidation().whenComplete(() async =>
        Timer(const Duration(seconds: 3), () {
          if (finalContactNumber != null) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          } else if (finalEmail != null) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const IntroScreen()));
          }
        }));
  }

  // If shared preferences have an instance that comes from the current user then
  // it accepts the validation for the existing account.
  // then stored it in final Email global variable.
  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    var obtainedContactNumber = sharedPreferences.getString('contact');

    setState(() {
      finalEmail = obtainedEmail;
      finalContactNumber = obtainedContactNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.grey[300]
              /* gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [Colors.black, Colors.red, Colors.black])*/
              ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 250.0,
                width: 350.0,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/BCONS_logo.png'),
                        fit: BoxFit.cover)),
              ),
              const Text(
                'All about Saving Lives',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    fontFamily: 'PoppinsBold'),
              ),
              const SizedBox(
                height: 30.0,
              ),
              const CircularProgressIndicator(
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
