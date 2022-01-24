import 'package:bcons_app/model/user_model.dart';
import 'package:bcons_app/screens/Sign_up_screen/sign_up_one.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:fluttertoast/fluttertoast.dart';
import '../login_screen.dart';

class SignUpTwoScreen extends StatefulWidget {
  const SignUpTwoScreen({Key? key}) : super(key: key);

  @override
  _SignUpTwoScreenState createState() => _SignUpTwoScreenState();
}

class _SignUpTwoScreenState extends State<SignUpTwoScreen> {
  final _formkey = GlobalKey<FormState>();
  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();
  final _confirmPasswordEditingController = TextEditingController();
  bool isChecked = false;

  final firebase_auth.FirebaseAuth firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[600],
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 30.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30.0),
                      Form(
                        key: _formkey,
                        child: Container(
                          height: 550.0,
                          width: 400.0,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Container(
                                      height: 150.0,
                                      width: 150.0,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/access_account.png'),
                                              fit: BoxFit.contain))),
                                  const SizedBox(height: 5.0),
                                  textForm(
                                      'Email',
                                      Icon(Icons.email,
                                          size: 20.0, color: Colors.grey[600]),
                                      false,
                                      _emailEditingController,
                                      'emailValidator'),
                                  const SizedBox(height: 15.0),
                                  textForm(
                                      'Password',
                                      Icon(Icons.visibility,
                                          size: 20.0, color: Colors.grey[600]),
                                      true,
                                      _passwordEditingController,
                                      'passwordValidator'),
                                  const SizedBox(height: 15.0),
                                  textForm(
                                      'Confirm Password',
                                      Icon(Icons.lock,
                                          size: 20.0, color: Colors.grey[600]),
                                      true,
                                      _confirmPasswordEditingController,
                                      'confirmPasswordValidator'),
                                  const SizedBox(height: 5.0),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value: isChecked,
                                        onChanged: (b) {
                                          setState(() {
                                            isChecked = b!;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        'Agree with the',
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 10.0),
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        'Terms and Conditions',
                                        style: TextStyle(
                                            color: Colors.red[600],
                                            fontSize: 10.0),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5.0),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      fixedSize: Size(
                                          MediaQuery.of(context).size.width,
                                          50.0),
                                      primary: Colors.red[600],
                                    ),
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have an account?',
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 10.0),
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
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20.0),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          Navigator.pop(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SignUpOneScreen()));
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.grey[200],
                                      ),
                                      child: Text(
                                        '< B A C K',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[600]),
                                      ),
                                    ),
                                  )
                                ],
                              ),
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

  Widget textForm(String labelText, Icon icon, bool boolean,
      TextEditingController controller, String validator) {
    const String _emailValidator = 'emailValidator';
    const String _passwordValidator = 'passwordValidator';
    const String _confirmPasswordValidator = 'confirmPasswordValidator';

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: TextFormField(
        autofocus: false,
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
          if (_confirmPasswordValidator == validator) {
            if (_confirmPasswordEditingController.text !=
                _passwordEditingController.text) {
              return 'Password dont match';
            }
            return null;
          }
        },
        obscureText: boolean,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          labelText: labelText,
          suffixIcon: InkWell(
              child: icon,
              onTap: () {
                boolean = !boolean;
                setState(() {});
              }),
          fillColor: Colors.grey[200],
          filled: true,
          labelStyle: TextStyle(
            fontSize: 17.0,
            color: Colors.grey[600],
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFireStore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e);
      });
    }
  }

  void postDetailsToFireStore() async {
    //calling our FireStore
    //calling the User Model
    //sending the values to firestore

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = firebaseAuth.currentUser;

    UserModel userModel = UserModel();

    //writing all the values
  }
}
