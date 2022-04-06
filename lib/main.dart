import 'package:bcons_app/PracticeFunctions/machineLearning.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/Emergency%20Libraries/emergency_list_tips.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/Libraries/emergency_libraries.dart';
import 'package:bcons_app/screens/Sign_up_screen/phone_auth_signUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        name: 'bcons-app-7fbb3',
        options: const FirebaseOptions(
            apiKey: 'AIzaSyCymQeagiTpFokPYDjszGhV6kxbmQvk',
            appId: '1:677774245629:android:1e52d895jq80b0ac44ef70894',
            messagingSenderId: '677774245629',
            projectId: 'bcons-app-7fbb3'));
    runApp(const MyApp());
  }
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
