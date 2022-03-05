import 'dart:async';

import 'package:bcons_app/Service/AuthService.dart';
import 'package:bcons_app/model/user_model.dart';
import 'package:bcons_app/screens/Sign_up_screen/privacyPolicy.dart';
import 'package:bcons_app/screens/Sign_up_screen/termsAndConditions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HomeScreen/home_screen.dart';

class PhoneAuthMultiStepper extends StatefulWidget {
  const PhoneAuthMultiStepper({Key? key}) : super(key: key);

  @override
  _PhoneAuthMultiStepperState createState() => _PhoneAuthMultiStepperState();
}

class _PhoneAuthMultiStepperState extends State<PhoneAuthMultiStepper> {
  int currentStepIndex = 0;
  final _formkey = GlobalKey<FormState>();
  final _firstNameEditingController = TextEditingController();
  final _emailEditingController = TextEditingController();
  final _lastNameEditingController = TextEditingController();
  final _midNameEditingController = TextEditingController();
  final _genderEditingController = TextEditingController();
  final _contactNumberEditingController = TextEditingController();
  final _streetEditingController = TextEditingController();
  final _brgyEditingController = TextEditingController();
  final _municipalityEditingController = TextEditingController();
  final _provinceEditingController = TextEditingController();
  bool isChecked = false;

  DateTime initialDate = DateTime.now();
  DateTime? date;
  String textSelect = 'Press to Select your Birthday';
  int startTime = 60;
  bool sent = false;
  String buttonName = 'Send';
  String verificationIDFinal = '';
  String smsCode = '';
  bool circular = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  firebase_auth.User? user = firebaseAuth.currentUser;
  UserModel userModel = UserModel();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final storage = const FlutterSecureStorage();

  //Show Date Picker
  Future<void> selectDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    );
    if (newDate == null) return;
    if ((newDate != null) && newDate != initialDate) {
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

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    PhoneVerificationCompleted verificationCompleted;
    PhoneVerificationFailed verificationFailed;
    PhoneCodeSent codeSent;
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout;

    verificationCompleted = (PhoneAuthCredential phoneAuthCredential) async {
      showSnackBar(context, 'Verification Completed');
    };

    verificationFailed = (FirebaseAuthException exception) {
      showSnackBar(context, exception.toString());
    };

    codeSent = (String verificationID, [int? forceResendingToken]) {
      showSnackBar(
          context, 'Verification Code sent successfully on the phone number');
      setData(verificationID);
    };

    codeAutoRetrievalTimeout = (String verificationID) {
      showSnackBar(context, 'Verification Time Out');
    };
    try {
      firebaseAuth.verifyPhoneNumber(
          timeout: const Duration(seconds: 60),
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void postDetailsToFireStore() async {
    userModel.uid = user?.uid;
    userModel.email = _emailEditingController.text;
    userModel.firstName = _firstNameEditingController.text;
    userModel.lastName = _lastNameEditingController.text;
    userModel.middleInitial = _midNameEditingController.text;
    userModel.gender = _genderEditingController.text;
    userModel.contactNumber = _contactNumberEditingController.text;
    userModel.birthday = getDate();
    userModel.street = _streetEditingController.text;
    userModel.brgy = _brgyEditingController.text;
    userModel.municipality = _municipalityEditingController.text;
    userModel.province = _provinceEditingController.text;

    await firebaseFirestore
        .collection("Users")
        .doc(user!.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: 'Account Created Successfully');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }

  Future<void> signUpWithPhoneNumber(
      String verificationID, String smsCode, BuildContext context) async {
    AuthCredential authCredential;
    if (_formkey.currentState!.validate()) {
      try {
        authCredential = PhoneAuthProvider.credential(
            verificationId: verificationID, smsCode: smsCode);
        await firebaseAuth
            .signInWithCredential(authCredential)
            .then((value) => {postDetailsToFireStore()})
            .catchError((e) {
          setState(() {
            circular = false;
          });
          Fluttertoast.showToast(msg: e);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false);
        });
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }
  }

  void storeTokenAndData(UserCredential userCredential) async {
    await storage.write(
        key: 'token', value: userCredential.credential?.token.toString());
    await storage.write(
        key: 'userCredential', value: userCredential.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
        appBar: AppBar(
          title: const Text(
            'Sign Up',
            style: TextStyle(
                fontFamily: 'PoppinsBold',
                letterSpacing: 2.0,
                color: Colors.white,
                fontSize: 20.0),
          ),
          leading: InkWell(
            child: const Icon(
              Icons.arrow_back,
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: const Color(0xffcc021d),
        ),
        body: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 60,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [Colors.black, Colors.red, Colors.black])),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 35, horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                        key: _formkey,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(children: [
                            SizedBox(
                              height: 510.0,
                              width: 400.0,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                          primary: Color(0xffcc021d))),
                                  child: Stepper(
                                    currentStep: currentStepIndex,
                                    type: StepperType.horizontal,
                                    onStepContinue: () async {
                                      if (currentStepIndex != 2) {
                                        setState(() {
                                          currentStepIndex += 1;
                                        });
                                      } else if (currentStepIndex == 2 &&
                                          isChecked == true) {
                                        final SharedPreferences
                                            sharedPreferences =
                                            await SharedPreferences
                                                .getInstance();
                                        sharedPreferences.setString(
                                            'contactNumber',
                                            _contactNumberEditingController
                                                .text);
                                        signUpWithPhoneNumber(
                                            verificationIDFinal,
                                            smsCode,
                                            context);
                                        setState(() {
                                          circular = true;
                                        });
                                      }
                                    },
                                    onStepCancel: () {
                                      if (currentStepIndex != 0) {
                                        setState(() {
                                          currentStepIndex -= 1;
                                        });
                                      }
                                    },
                                    steps: [
                                      Step(
                                        state: currentStepIndex <= 0
                                            ? StepState.editing
                                            : StepState.complete,
                                        isActive: currentStepIndex >= 0,
                                        title: const Text('Account'),
                                        content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              textForm(
                                                  'Last Name',
                                                  _lastNameEditingController,
                                                  'lastNameValidator',
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  45),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              textForm(
                                                  'First Name',
                                                  _firstNameEditingController,
                                                  'firstNameValidator',
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  45.0),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              Row(
                                                children: [
                                                  textForm(
                                                      'Middle Initial',
                                                      _midNameEditingController,
                                                      'null',
                                                      136.0,
                                                      45.0),
                                                  const SizedBox(width: 10.0),
                                                  textForm(
                                                      'Gender',
                                                      _genderEditingController,
                                                      'null',
                                                      136.0,
                                                      45.0),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              numberField(
                                                  _contactNumberEditingController),
                                              const SizedBox(height: 10.0),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Row(children: [
                                                  Expanded(
                                                      child: Container(
                                                    height: 1,
                                                    color: Colors.black,
                                                  )),
                                                  const Text(
                                                    ' Enter 6 OTP digit ',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontFamily:
                                                          'PoppinsRegular',
                                                      letterSpacing: 1.5,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Container(
                                                    height: 1,
                                                    color: Colors.black,
                                                  )),
                                                ]),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              otpField(),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              RichText(
                                                  text: TextSpan(children: [
                                                const TextSpan(
                                                  text: 'Send OTP again in ',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontFamily:
                                                        'PoppinsRegular',
                                                    color: Colors.black,
                                                    letterSpacing: 1.5,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '00:$startTime',
                                                  style: const TextStyle(
                                                      fontSize: 12.0,
                                                      fontFamily:
                                                          'PoppinsRegular',
                                                      letterSpacing: 1.5,
                                                      color: Color(0xffcc021d)),
                                                ),
                                                const TextSpan(
                                                  text: ' sec',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontFamily:
                                                        'PoppinsRegular',
                                                    letterSpacing: 1.5,
                                                    color: Colors.black,
                                                  ),
                                                )
                                              ])),
                                            ]),
                                      ),
                                      Step(
                                          state: currentStepIndex <= 1
                                              ? StepState.editing
                                              : StepState.complete,
                                          isActive: currentStepIndex >= 1,
                                          title: const Text('Others'),
                                          content: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        selectDate(context);
                                                      });
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                        side: const BorderSide(
                                                            width: 1.0,
                                                            color: Colors.grey),
                                                      ),
                                                      fixedSize: Size(
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                          45.0),
                                                      primary: Colors.white,
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          getDate(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                                'PoppinsRegular',
                                                            letterSpacing: 1.5,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                textForm(
                                                    'Email',
                                                    _emailEditingController,
                                                    'emailValidator',
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    50.0),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                textForm(
                                                    'Street/Purok',
                                                    _streetEditingController,
                                                    'streetAndBrgyValidator',
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    45.0),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                textForm(
                                                    'Brgy',
                                                    _brgyEditingController,
                                                    'streetAndBrgyValidator',
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    45.0),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                textForm(
                                                    'Municipality',
                                                    _municipalityEditingController,
                                                    'municipalityValidator',
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    45.0),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                textForm(
                                                    'Province',
                                                    _provinceEditingController,
                                                    'provinceValidator',
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    45.0),
                                              ])),
                                      Step(
                                          state: StepState.complete,
                                          isActive: currentStepIndex >= 2,
                                          title: const Text('Confirm'),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  'Name: ${_lastNameEditingController.text}, ${_firstNameEditingController.text} ${_midNameEditingController.text}',
                                                  style: const TextStyle(
                                                    fontSize: 15.0,
                                                    fontFamily:
                                                        'PoppinsRegular',
                                                    letterSpacing: 1.5,
                                                    color: Colors.black,
                                                  )),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                  'Gender: ${_genderEditingController.text}',
                                                  style: const TextStyle(
                                                    fontSize: 15.0,
                                                    fontFamily:
                                                        'PoppinsRegular',
                                                    letterSpacing: 1.5,
                                                    color: Colors.black,
                                                  )),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                  'Contact No: +63${_contactNumberEditingController.text}',
                                                  style: const TextStyle(
                                                    fontSize: 15.0,
                                                    fontFamily:
                                                        'PoppinsRegular',
                                                    letterSpacing: 1.5,
                                                    color: Colors.black,
                                                  )),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                              Text('Birthday: ${getDate()}',
                                                  style: const TextStyle(
                                                    fontSize: 15.0,
                                                    fontFamily:
                                                        'PoppinsRegular',
                                                    letterSpacing: 1.5,
                                                    color: Colors.black,
                                                  )),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                  'Address: ${_streetEditingController.text} ${_brgyEditingController.text} ${_municipalityEditingController.text}, ${_provinceEditingController.text}',
                                                  style: const TextStyle(
                                                    fontSize: 15.0,
                                                    fontFamily:
                                                        'PoppinsRegular',
                                                    letterSpacing: 1.5,
                                                    color: Colors.black,
                                                  )),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Checkbox(
                                                    splashRadius: 5.0,
                                                    value: isChecked,
                                                    onChanged: (b) {
                                                      setState(() {
                                                        isChecked = b!;

                                                        isChecked
                                                            ? displayMessage()
                                                            : null;
                                                      });
                                                    },
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const TermsAndConditions()));
                                                      });
                                                    },
                                                    child: Text(
                                                      'Terms and Conditions',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.red[600],
                                                          fontSize: 10.0,
                                                          fontFamily:
                                                              'PoppinsRegular'),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  Text(
                                                    '|',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const PrivacyPolicy()));
                                                      });
                                                    },
                                                    child: Text(
                                                      'Privacy Policy',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.red[600],
                                                          fontSize: 10.0,
                                                          fontFamily:
                                                              'PoppinsRegular'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ))
                  ],
                ),
              )),
        ));
  }

  void startTimer() {
    const onSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onSec, (timer) {
      if (startTime == 0) {
        setState(() {
          timer.cancel();
          sent = false;
        });
      } else {
        setState(() {
          startTime--;
        });
      }
    });
  }

  Widget textForm(String labelText, TextEditingController controller,
      String validator, double width, double height) {
    const String firstNameValidator = 'firstNameValidator';
    const String lastNameValidator = 'lastNameValidator';
    const String contactNumberValidator = 'contactNumberValidator';
    const String emailValidator = 'emailValidator';
    const String streetValidator = 'streetAndBrgyValidator';
    const String brgyValidator = 'streetAndBrgyValidator';
    const String municipalityValidator = 'municipalityValidator';
    const String provinceValidator = 'provinceValidator';

    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        autofocus: false,
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
          if (streetValidator == validator) {
            if (value!.isEmpty) {
              return ("Street/Purok are required");
            }
            return null;
          }
          if (brgyValidator == validator) {
            if (value!.isEmpty) {
              return ("Brgy are required");
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
          return null;
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          labelText: labelText,
          fillColor: Colors.white,
          filled: true,
          labelStyle: TextStyle(
            fontSize: 12.0,
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

  Widget numberField(TextEditingController controller) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: TextFormField(
          autofocus: false,
          keyboardType: TextInputType.number,
          controller: controller,
          onSaved: (value) {
            controller.text = value!;
          },
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
            hintText: 'Enter your phone number',
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 3),
              child: Text(
                ' (+63) ',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontFamily: 'PoppinsRegular',
                  letterSpacing: 1.5,
                ),
              ),
            ),
            suffixIcon: InkWell(
              onTap: sent
                  ? null
                  : () async {
                      setState(() {
                        startTime = 60;
                        sent = true;
                        buttonName = 'Resend';
                      });
                      startTimer();
                      await verifyPhoneNumber(
                          '+63 ${_contactNumberEditingController.text}',
                          context,
                          setData);
                    },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 3),
                child: Text(
                  buttonName,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: sent ? Colors.grey : Colors.black,
                    fontFamily: 'PoppinsRegular',
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(
              fontSize: 10.0,
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
        ));
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width,
      fieldWidth: 40,
      otpFieldStyle: OtpFieldStyle(
          borderColor: Colors.black, backgroundColor: Colors.transparent),
      style: const TextStyle(
        fontSize: 15.0,
        color: Colors.black,
        fontFamily: 'PoppinsRegular',
      ),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode = pin;
        });
      },
    );
  }

  void setData(verificationID) {
    setState(() {
      verificationIDFinal = verificationID;
    });
    startTimer();
  }
}