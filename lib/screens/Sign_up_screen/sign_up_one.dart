import 'package:bcons_app/model/user_model.dart';
import 'package:bcons_app/screens/HomeScreen/home_screen.dart';
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
  final _firstNameEditingController = TextEditingController();
  final _lastNameEditingController = TextEditingController();
  final _midNameEditingController = TextEditingController();
  final _contactNumberEditingController = TextEditingController();
  final _bdayEditingController = TextEditingController();
  final _streetAndBrgyEditingController = TextEditingController();
  final _municipalityEditingController = TextEditingController();
  final _provinceEditingController = TextEditingController();
  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();
  final _confirmPasswordEditingController = TextEditingController();
  bool isChecked = false;
  bool isHiddenPassword = true;
  bool isHiddenConfirmPassword = true;
  bool circular = false;

  final firebase_auth.FirebaseAuth firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

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
    if (newDate != null && newDate != initialDate) {
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
    userModel.firstName = _firstNameEditingController.text;
    userModel.lastName = _lastNameEditingController.text;
    userModel.middleInitial = _midNameEditingController.text;
    userModel.contactNumber = _contactNumberEditingController.text;
    userModel.birthday = getDate();
    userModel.brgy = _streetAndBrgyEditingController.text;
    userModel.municipality = _municipalityEditingController.text;
    userModel.province = _provinceEditingController.text;

    await firebaseFirestore
        .collection("Users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: 'Account Created Successfully');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
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
  void displayMessage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          AlertDialog dialog = AlertDialog(
            content: const Text(
              'You have accepted the Terms and Conditions',
              style: TextStyle(
                  fontFamily: 'PoppinsRegular',
                  letterSpacing: 1.5,
                  fontSize: 15.0,
                  color: Colors.black),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Okay',
                      style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          letterSpacing: 1.5,
                          fontSize: 15.0,
                          color: Colors.black)))
            ],
          );
          return dialog;
        });
  }

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
                padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
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
                      const SizedBox(height: 5.0),
                      Form(
                        key: _formkey,
                        child: Container(
                          height: 600.0,
                          width: 400.0,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 12.0, 20.0, 8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    textForm(
                                        'Last Name',
                                        Icon(Icons.person,
                                            size: 20.0,
                                            color: Colors.grey[600]),
                                        _lastNameEditingController,
                                        'lastNameValidator',
                                        150.0,
                                        45.0),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    textForm(
                                        'First Name',
                                        Icon(Icons.person,
                                            size: 20.0,
                                            color: Colors.grey[600]),
                                        _firstNameEditingController,
                                        'firstNameValidator',
                                        150.0,
                                        45.0),
                                  ],
                                ),
                                const SizedBox(height: 13.0),
                                Row(
                                  children: [
                                    textForm(
                                        'M.I',
                                        Icon(Icons.person,
                                            size: 20.0,
                                            color: Colors.grey[600]),
                                        _midNameEditingController,
                                        'null',
                                        90.0,
                                        45.0),
                                    const SizedBox(width: 10.0),
                                    textForm(
                                        'Contact no.',
                                        Icon(Icons.phone,
                                            size: 20.0,
                                            color: Colors.grey[600]),
                                        _contactNumberEditingController,
                                        'contactNumberValidator',
                                        210.0,
                                        45.0),
                                  ],
                                ),
                                const SizedBox(height: 13.0),
                                textFormBirthday(
                                    getDate(),
                                    Icon(Icons.calendar_today,
                                        size: 20.0, color: Colors.grey[600]),
                                    MediaQuery.of(context).size.width,
                                    45.0),
                                /*ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectDate(context);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0),
                                      side: const BorderSide(
                                          width: 1.0, color: Colors.grey),
                                    ),
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width,
                                        45.0),
                                    primary: Colors.grey[200],
                                  ),
                                  child: Text(
                                    getDate(),
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),*/
                                const SizedBox(height: 13.0),
                                textForm(
                                    'Street & Brgy',
                                    Icon(Icons.location_on_rounded,
                                        size: 20.0, color: Colors.grey[600]),
                                    _streetAndBrgyEditingController,
                                    'streetAndBrgyValidator',
                                    MediaQuery.of(context).size.width,
                                    45.0),
                                const SizedBox(height: 13.0),
                                Row(
                                  children: [
                                    textForm(
                                        'Municipality',
                                        Icon(Icons.location_on_rounded,
                                            size: 20.0,
                                            color: Colors.grey[600]),
                                        _municipalityEditingController,
                                        'municipalityValidator',
                                        150.0,
                                        45.0),
                                    const SizedBox(width: 10.0),
                                    textForm(
                                        'Province',
                                        Icon(Icons.location_on_rounded,
                                            size: 20.0,
                                            color: Colors.grey[600]),
                                        _provinceEditingController,
                                        'provinceValidator',
                                        150.0,
                                        45.0),
                                  ],
                                ),
                                const SizedBox(height: 13.0),
                                textForm(
                                    'Email',
                                    Icon(Icons.email,
                                        size: 20.0, color: Colors.grey[600]),
                                    _emailEditingController,
                                    'emailValidator',
                                    MediaQuery.of(context).size.width,
                                    45.0),
                                const SizedBox(height: 13.0),
                                textFormPassword(
                                    'Password',
                                    Icon(Icons.visibility,
                                        size: 20.0, color: Colors.grey[600]),
                                    _passwordEditingController,
                                    'passwordValidator',
                                    MediaQuery.of(context).size.width,
                                    45.0),
                                const SizedBox(height: 13.0),
                                textFormConfirmPassword(
                                    'Confirm Password',
                                    Icon(Icons.visibility,
                                        size: 20.0, color: Colors.grey[600]),
                                    _confirmPasswordEditingController,
                                    'confirmPasswordValidator',
                                    MediaQuery.of(context).size.width,
                                    45.0),
                                const SizedBox(height: 1.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      splashRadius: 10.0,
                                      value: isChecked,
                                      onChanged: (b) {
                                        setState(() {
                                          isChecked = b!;
                                          isChecked ? displayMessage() : null;
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
                                          fontSize: 10.0,
                                          fontFamily: 'PoppinsRegular'),
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'Terms and Conditions',
                                      style: TextStyle(
                                          color: Colors.red[600],
                                          fontSize: 10.0,
                                          fontFamily: 'PoppinsRegular'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 1.0),
                                ElevatedButton(
                                  onPressed: () {
                                    signUp(_emailEditingController.text,
                                        _passwordEditingController.text);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width,
                                        45.0),
                                    primary: Colors.red[600],
                                  ),
                                  child: circular
                                      ? const CircularProgressIndicator(
                                          color: Colors.white)
                                      : const Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'PoppinsBold',
                                            fontSize: 20.0,
                                          ),
                                        ),
                                ),
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

  //Widgets for Text Form Field including the name, email, birthday, address, password and confirm password
  Widget textForm(String labelText, Icon icon, TextEditingController controller,
      String validator, double width, double height) {
    const String firstNameValidator = 'firstNameValidator';
    const String lastNameValidator = 'lastNameValidator';
    const String contactNumberValidator = 'contactNumberValidator';
    const String emailValidator = 'emailValidator';
    const String streetAndBrgyValidator = 'streetAndBrgyValidator';
    const String municipalityValidator = 'municipalityValidator';
    const String provinceValidator = 'provinceValidator';

    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        autofocus: true,
        controller: controller,
        onSaved: (value) {
          controller.text = value!;
        },
        validator: (value) {
          if (firstNameValidator == validator) {
            RegExp regex = RegExp(r'^.{3,}$');
            if (value!.isEmpty) {
              return ("First name is required");
            }
            if (!regex.hasMatch(value)) {
              return ("Enter valid first name(Min. 3 Characters)");
            }
            return null;
          }
          if (lastNameValidator == validator) {
            RegExp regex = RegExp(r'^.{3,}$');
            if (value!.isEmpty) {
              return ("Last name is required");
            }
            if (!regex.hasMatch(value)) {
              return ("Enter valid last name(Min. 2 Characters)");
            }
            return null;
          }
          if (contactNumberValidator == validator) {
            RegExp regex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
            if (value!.isEmpty) {
              return ("Contact number is required");
            }
            if (!regex.hasMatch(value)) {
              return ("Enter Valid Phone Number");
            }
            return null;
          }
          if (streetAndBrgyValidator == validator) {
            if (value!.isEmpty) {
              return ("Street and Brgy are required");
            }
            return null;
          }
          if (municipalityValidator == validator) {
            if (value!.isEmpty) {
              return ("Municipality is required");
            }
            return null;
          }
          if (provinceValidator == validator) {
            if (value!.isEmpty) {
              return ("Province is required");
            }
            return null;
          }
          if (emailValidator == validator) {
            if (value!.isEmpty) {
              return 'Please Enter your Email';
            }
            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                .hasMatch(value)) {
              return ("Please Enter a valid Email");
            }
            return null;
          }
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          labelText: labelText,
          suffixIcon: icon,
          fillColor: Colors.grey[200],
          filled: true,
          labelStyle: TextStyle(
            fontSize: 10.0,
            color: Colors.grey[600],
            fontFamily: 'PoppinsRegular',
            letterSpacing: 1.5,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 1.0, color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget textFormPassword(
      String labelText,
      Icon icon,
      TextEditingController controller,
      String validator,
      double width,
      double height) {
    const String passwordValidator = 'passwordValidator';

    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        autofocus: true,
        controller: controller,
        onSaved: (value) {
          controller.text = value!;
        },
        validator: (value) {
          if (passwordValidator == validator) {
            RegExp regex = RegExp(r'^.{6,}$');
            if (value!.isEmpty) {
              return ("Password is required for Creating an account");
            }
            if (!regex.hasMatch(value)) {
              return ("Enter Valid Password(Min. 6 Character)");
            }
            return null;
          }
        },
        obscureText: isHiddenPassword,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          labelText: labelText,
          suffixIcon: InkWell(child: icon, onTap: togglePasswordView),
          fillColor: Colors.grey[200],
          filled: true,
          labelStyle: TextStyle(
            fontSize: 10.0,
            color: Colors.grey[600],
            fontFamily: 'PoppinsRegular',
            letterSpacing: 1.5,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 1.0, color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget textFormConfirmPassword(
      String labelText,
      Icon icon,
      TextEditingController controller,
      String validator,
      double width,
      double height) {
    const String confirmPasswordValidator = 'confirmPasswordValidator';

    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        autofocus: true,
        controller: controller,
        onSaved: (value) {
          controller.text = value!;
        },
        validator: (value) {
          if (confirmPasswordValidator == validator) {
            if (_confirmPasswordEditingController.text !=
                _passwordEditingController.text) {
              return 'Password dont match';
            }
            return null;
          }
        },
        obscureText: isHiddenConfirmPassword,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          labelText: labelText,
          suffixIcon: InkWell(child: icon, onTap: toggleConfirmPasswordView),
          fillColor: Colors.grey[200],
          filled: true,
          labelStyle: TextStyle(
            fontSize: 10.0,
            color: Colors.grey[600],
            fontFamily: 'PoppinsRegular',
            letterSpacing: 1.5,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 1.0, color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget textFormBirthday(
      String labelText, Icon icon, double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        autofocus: true,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          labelText: labelText,
          suffixIcon: InkWell(
              child: icon,
              onTap: () {
                selectDate(context);
              }),
          fillColor: Colors.grey[200],
          filled: true,
          labelStyle: TextStyle(
            fontSize: 10.0,
            color: Colors.grey[600],
            fontFamily: 'PoppinsRegular',
            letterSpacing: 1.5,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 1.0, color: Colors.grey),
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
