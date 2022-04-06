import 'package:bcons_app/Service/AuthService.dart';
import 'package:bcons_app/model/user_model.dart';
import 'package:bcons_app/screens/HomeScreen/home_screen.dart';
import 'package:bcons_app/screens/Sign_up_screen/multi_stepper.dart';
import 'package:bcons_app/screens/Sign_up_screen/phone_auth_signUp.dart';
import 'package:bcons_app/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class SignUpOneScreen extends StatefulWidget {
  const SignUpOneScreen({Key? key}) : super(key: key);

  @override
  _SignUpOneScreenState createState() => _SignUpOneScreenState();
}

class _SignUpOneScreenState extends State<SignUpOneScreen> {
  final _formkey = GlobalKey<FormState>();
  bool isChecked = false;
  bool isHiddenPassword = true;
  bool isHiddenConfirmPassword = true;
  bool circular = false;

  final firebase_auth.FirebaseAuth firebaseAuth =
      firebase_auth.FirebaseAuth.instance;
  final AuthService _authService = AuthService();

  DateTime initialDate = DateTime.now();
  DateTime? date;
  String textSelect = 'Press Icon  to Select your Birthday';

  //Show Date Picker
  Future<void> selectDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    );
    if (newDate == null) return;
    if (newDate != initialDate) {
      setState(() {
        date = newDate;
      });
    }
  }

  // logic to get date, instance from the date picker
  String getDate() {
    if (date == null) {
      return textSelect;
    } else {
      return DateFormat('MM/dd/yyyy').format(date!);
    }
  }

  //Sign Up Process and Saving data using Firebase Authentication
  void signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        circular = true;
      });
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFireStore()})
          .catchError((e) {
        setState(() {
          circular = false;
        });
        Fluttertoast.showToast(msg: e);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
    }
  }

  void postDetailsToFireStore() async {
    //calling our FireStore
    //calling the User Model
    //sending the values to firestore

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebase_auth.User? user = firebaseAuth.currentUser;

    UserModel userModel = UserModel();

    //writing all the values
    userModel.uid = user!.uid;
    userModel.email = user.email;

    await firebaseFirestore
        .collection("Users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: 'Account Created Successfully');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MultiStepperSignUp()),
        (route) => false);
  }

  //Show hidden password
  void togglePasswordView() {
    isHiddenPassword = !isHiddenPassword;
    setState(() {});
  }

  //Show hidden confirm password
  void toggleConfirmPasswordView() {
    isHiddenConfirmPassword = !isHiddenConfirmPassword;
    setState(() {});
  }

  //Show dialog box in Check Box

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[600],
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
                        'Sign Up',
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
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 12.0, 20.0, 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /*buttonItems('assets/images/google.png',
                                    'Sign up with Google', () async {
                                  await _authService.googleSignIn(context);
                                }),*/
                                Container(
                                  height: 150.0,
                                  width: 150.0,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/access_account.png'),
                                          fit: BoxFit.cover)),
                                ),
                                const SizedBox(height: 10),
                                buttonItems('assets/images/phone.png',
                                    'Sign up with Mobile', () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PhoneAuthSignUp()));
                                }),
                                const SizedBox(height: 15),
                                const Text('or',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'PoppinsRegular',
                                      letterSpacing: 2,
                                      fontSize: 17.0,
                                    )),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MultiStepperSignUp()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      fixedSize: Size(
                                          MediaQuery.of(context).size.width,
                                          100.0),
                                      primary: Colors.red[600],
                                    ),
                                    child: circular
                                        ? const CircularProgressIndicator(
                                            color: Colors.white)
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                'Sign Up with',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                'Email and Password',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'PoppinsBold',
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                            ],
                                          )),
                                const SizedBox(height: 8.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already have an account?',
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 10.0,
                                          fontFamily: 'PoppinsRegular'),
                                    ),
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
                                                      const LoginScreen()));
                                        });
                                      },
                                      child: Text(
                                        'Sign In',
                                        style: TextStyle(
                                            color: Colors.red[600],
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'PoppinsRegular'),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 50,
                                )
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
}
