import 'package:bcons_app/PracticeFunctions/machineLearning.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/Emergency%20Libraries/emergency_list_tips.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

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
