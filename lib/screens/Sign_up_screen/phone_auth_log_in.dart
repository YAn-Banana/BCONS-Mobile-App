import 'dart:async';
import 'package:bcons_app/Service/AuthService.dart';
import 'package:bcons_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:shared_preferences/shared_preferences.dart';
import '../HomeScreen/home_screen.dart';

class PhoneAuthLoginScreen extends StatefulWidget {
  const PhoneAuthLoginScreen({Key? key}) : super(key: key);

  @override
  _PhoneAuthLoginScreenState createState() => _PhoneAuthLoginScreenState();
}

class _PhoneAuthLoginScreenState extends State<PhoneAuthLoginScreen> {
  final _contactNumberEditingController = TextEditingController();
  bool circular = false;
  int startTime = 60;
  bool sent = false;
  String buttonName = 'Send';
  String verificationIDFinal = '';
  String smsCode = '';
  bool isValidUser = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  firebase_auth.User? user = firebaseAuth.currentUser;
  final AuthService _authService = AuthService();
  UserModel userModel = UserModel();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final storage = const FlutterSecureStorage();

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
      auth.verifyPhoneNumber(
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

  Future<void> signInWithPhoneNumber(
      String verificationID, String smsCode, BuildContext context) async {
    AuthCredential authCredential;

    try {
      authCredential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: smsCode);
      await firebaseFirestore
          .collection('Users')
          .where('contactNumber',
              isEqualTo: '+63 ' + _contactNumberEditingController.text.trim())
          .get()
          .then((result) {
        if (result.docs.isNotEmpty) {
          setState(() {
            isValidUser = true;
          });
        } else {
          setState(() {
            isValidUser = false;
          });
        }
      });
      if (isValidUser == true) {
        await auth.signInWithCredential(authCredential).then((value) =>
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => const HomeScreen()),
                (route) => false));
        showSnackBar(context, 'Logged In');
      } else {
        showSnackBar(context, 'Phone number not found, Please sign up first');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
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
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: SizedBox(
                        height: 510.0,
                        width: 400.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                      primary: Color(0xffcc021d))),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    numberField(
                                        _contactNumberEditingController),
                                    const SizedBox(height: 40.0),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
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
                                            fontFamily: 'PoppinsRegular',
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
                                      height: 20,
                                    ),
                                    RichText(
                                        text: TextSpan(children: [
                                      const TextSpan(
                                        text: 'Send OTP again in ',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: 'PoppinsRegular',
                                          color: Colors.black,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '00:$startTime',
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'PoppinsRegular',
                                            letterSpacing: 1.5,
                                            color: Color(0xffcc021d)),
                                      ),
                                      const TextSpan(
                                        text: ' sec',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: 'PoppinsRegular',
                                          letterSpacing: 1.5,
                                          color: Colors.black,
                                        ),
                                      )
                                    ])),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        final SharedPreferences
                                            sharedPreferences =
                                            await SharedPreferences
                                                .getInstance();
                                        sharedPreferences.setString(
                                            'contactNumber',
                                            _contactNumberEditingController
                                                .text);
                                        signInWithPhoneNumber(
                                            verificationIDFinal,
                                            smsCode,
                                            context);
                                        setState(() {
                                          circular = true;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        fixedSize: Size(
                                            MediaQuery.of(context).size.width,
                                            50.0),
                                        primary: const Color(0xffcc021d),
                                      ),
                                      child: circular
                                          ? const CircularProgressIndicator(
                                              color: Colors.white)
                                          : const Text(
                                              'Verify',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 2.0,
                                                  fontSize: 20.0,
                                                  fontFamily: 'PoppinsBold'),
                                            ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    )
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
          circular = false;
        });
      } else {
        setState(() {
          startTime--;
        });
      }
    });
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
