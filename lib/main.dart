import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/user_profile.dart';
import 'package:bcons_app/screens/Sign_up_screen/sign_up_two.dart';
import 'package:bcons_app/screens/HomeScreen/home_screen.dart';
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
