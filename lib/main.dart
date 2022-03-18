import 'package:bcons_app/PracticeFunctions/Create%20PDF/manual_report_with_confirmation.dart';

import 'package:bcons_app/PracticeFunctions/getAge.dart';
import 'package:bcons_app/PracticeFunctions/getUserCurrentLocation.dart';
import 'package:bcons_app/PracticeFunctions/machineLearning.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/Emergency%20Libraries/emergency_list_tips.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/userProfile.dart';
import 'package:bcons_app/screens/HomeScreen/bottom_navigation_bar.dart';
import 'package:bcons_app/screens/Sign_up_screen/multi_stepper.dart';
import 'package:bcons_app/screens/Sign_up_screen/phone_auth_log_in.dart';
import 'package:bcons_app/screens/Sign_up_screen/phone_auth_sign_up.dart';
import 'package:bcons_app/screens/Sign_up_screen/privacyPolicy.dart';
import 'package:bcons_app/screens/HomeScreen/home_screen.dart';
import 'package:bcons_app/screens/Sign_up_screen/termsAndConditions.dart';
import 'package:bcons_app/screens/intro_screen.dart';
import 'package:bcons_app/screens/login_screen.dart';
import 'package:bcons_app/screens/Sign_up_screen/sign_up_one.dart';
import 'package:bcons_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCymQeagiTpFokPYDjszGhV6kxbjq8mQvk',
          appId: '1:677774245629:android:1e52d8950b0ac44ef70894',
          messagingSenderId: '677774245629',
          projectId: 'bcons-app-7fbb3'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xffd90824),
        ),
        home: const SplashScreen());
  }
}
