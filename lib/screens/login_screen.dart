import 'package:bcons_app/screens/Sign_up_screen/sign_up_one.dart';
import 'package:bcons_app/screens/HomeScreen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Sign_up_screen/phone_auth_log_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final emlEditingController = TextEditingController();
  final pwdEditingController = TextEditingController();
  bool isChecked = false;
  bool isHiddenPassword = true;
  bool viewPassword = false;
  bool circular = false;
  final firebase_auth.FirebaseAuth firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

  // Method for Signing In which comes from Firebase Authentication
  // Then Navigate to the Home Screen
  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        circular = true;
      });
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: 'Login Successfully'),
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()))
              })
          .catchError((e) {
        setState(() {
          circular = false;
        });
        Fluttertoast.showToast(msg: e.toString());
      });
    }
  }

  //logic for password visibility
  void togglePasswordView() {
    isHiddenPassword = !isHiddenPassword;
    setState(() {
      viewPassword = !viewPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [Colors.black, Colors.red, Colors.black])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 30.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PoppinsBold',
                            letterSpacing: 2.0),
                      ),
                      const SizedBox(height: 20.0),
                      Form(
                        key: _formkey,
                        child: Container(
                          height: 550.0,
                          width: 400.0,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                buttonItems('assets/images/google.png',
                                    'Sign in with Google', () {}),
                                const SizedBox(height: 10),
                                buttonItems('assets/images/phone.png',
                                    'Sign in with Mobile', () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PhoneAuthLoginScreen()));
                                }),
                                const SizedBox(height: 15),
                                const Text('or',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'PoppinsRegular',
                                      letterSpacing: 2,
                                      fontSize: 17.0,
                                    )),
                                const SizedBox(height: 15.0),
                                textForm(
                                    'Email',
                                    Icon(
                                      Icons.email,
                                      size: 20.0,
                                      color: Colors.grey[600],
                                    ),
                                    emlEditingController,
                                    'emailValidator'),
                                const SizedBox(height: 5.0),
                                textFormPassword(
                                    'Password',
                                    Icon(
                                        viewPassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        size: 20.0,
                                        color: Colors.grey[600]),
                                    pwdEditingController,
                                    'passwordValidator'),
                                const SizedBox(height: 5.0),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'Forgot Password??',
                                    style: TextStyle(
                                      color: Colors.red[600],
                                      fontSize: 10.0,
                                      fontFamily: 'PoppinsRegular',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 7.0),
                                ElevatedButton(
                                  onPressed: () async {
                                    final SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    sharedPreferences.setString(
                                        'email', emlEditingController.text);
                                    signIn(emlEditingController.text,
                                        pwdEditingController.text);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width,
                                        50.0),
                                    primary: Colors.red[600],
                                  ),
                                  child: circular
                                      ? const CircularProgressIndicator(
                                          color: Colors.white)
                                      : const Text(
                                          'Sign in',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 2.0,
                                              fontSize: 20.0,
                                              fontFamily: 'PoppinsBold'),
                                        ),
                                ),
                                const SizedBox(height: 5.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Don\'t have an account? ',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 10.0,
                                          fontFamily: 'PoppinsRegular',
                                        )),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SignUpOneScreen()));
                                        });
                                      },
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: Colors.red[600],
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'PoppinsRegular',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonItems(String imagePath, String buttonName, Function onTap) {
    return InkWell(
      onTap: () => onTap(),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 55,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(width: 1, color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 15.0,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(imagePath),
                  ),
                  const SizedBox(width: 10),
                  Text(buttonName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 2,
                        fontSize: 15.0,
                      ))
                ],
              ))),
    );
  }

  //Widget for Text Form Field,
  //This includes the form fields for email and password
  Widget textForm(String labelText, Icon icon, TextEditingController controller,
      String validator) {
    const String _emailValidator = 'emailValidator';

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: TextFormField(
        controller: controller,
        onSaved: (value) {
          controller.text = value!;
        },
        validator: (value) {
          if (_emailValidator == validator) {
            if (value!.isEmpty) {
              return 'Please Enter your Email';
            }
            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                .hasMatch(value)) {
              return ("Please Enter a valid Email");
            }
            return null;
          }
          return null;
        },
        autofocus: false,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          labelText: labelText,
          suffixIcon: icon,
          fillColor: Colors.white,
          filled: true,
          labelStyle: TextStyle(
            fontSize: 15.0,
            color: Colors.grey[600],
            fontFamily: 'PoppinsRegular',
            letterSpacing: 1.5,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 1.5, color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget textFormPassword(String labelText, Icon icon,
      TextEditingController controller, String validator) {
    const String _passwordValidator = 'passwordValidator';

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: TextFormField(
        controller: controller,
        onSaved: (value) {
          controller.text = value!;
        },
        validator: (value) {
          if (_passwordValidator == validator) {
            RegExp regex = RegExp(r'^.{6,}$');
            if (value!.isEmpty) {
              return ("Password is required for Login");
            }
            if (!regex.hasMatch(value)) {
              return ("Enter Valid Password(Min. 6 Character)");
            }
            return null;
          }
          return null;
        },
        obscureText: isHiddenPassword,
        autofocus: false,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          suffixIcon: InkWell(child: icon, onTap: togglePasswordView),
          fillColor: Colors.white,
          filled: true,
          labelText: labelText,
          labelStyle: TextStyle(
              fontSize: 15.0,
              color: Colors.grey[600],
              fontFamily: 'PoppinsRegular',
              letterSpacing: 1.5),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 1.5, color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
