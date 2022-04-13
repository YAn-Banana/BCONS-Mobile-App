import 'package:bcons_app/model/user_model.dart';
import 'package:bcons_app/screens/Sign_up_screen/privacyPolicy.dart';
import 'package:bcons_app/screens/Sign_up_screen/termsAndConditions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HomeScreen/home_screen.dart';

class MultiStepperSignUp extends StatefulWidget {
  const MultiStepperSignUp({Key? key}) : super(key: key);

  @override
  _MultiStepperSignUpState createState() => _MultiStepperSignUpState();
}

class _MultiStepperSignUpState extends State<MultiStepperSignUp> {
  int currentStepIndex = 0;
  final _formkey = GlobalKey<FormState>();
  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();
  final _firstNameEditingController = TextEditingController();
  final _lastNameEditingController = TextEditingController();
  final _midNameEditingController = TextEditingController();
  final _contactNumberEditingController = TextEditingController();
  final _streetEditingController = TextEditingController();
  final _brgyEditingController = TextEditingController();
  bool isChecked = false;
  bool isHiddenPassword = true;
  bool viewPassword = false;
  bool circular = false;

  DateTime initialDate = DateTime.now();
  DateTime? date;
  String textSelect = 'Select your birthday';
  int? days;

  String? bloodTypeValue;
  String? genderValue;
  String? municipalityValue;
  String? provinceValue;

  final municipalityList = [
    'Angat',
    'Balagtas',
    'Baliuag',
    'Bocaue',
    'Bulakan',
    'Bustos',
    'Calumpit',
    'Dona Remdios Trinidad',
    'Guiguinto',
    'Hagonoy',
    'Malolos',
    'Marilao',
    'Norzagaray',
    'Obando',
    'Pandi',
    'Paombong',
    'Plaridel',
    'Pulilan',
    'San Ildefonso',
    'San Miguel',
    'San Rafael',
    'Santa Maria'
  ];
  final provinceList = ['Bulacan'];

  final bloodTypeList = [
    'A+',
    'O+',
    'B+',
    'AB+',
    'A-',
    '0-',
    'B-',
    'AB-',
    'None'
  ];
  final genderList = [
    'Male',
    'Female',
  ];

  DropdownMenuItem<String> buildMenuItem(String emergency) {
    return DropdownMenuItem(
      value: emergency,
      child: Text(
        emergency,
        style: const TextStyle(
            fontFamily: 'PoppinsRegular',
            letterSpacing: 1.5,
            color: Colors.black,
            fontSize: 12.0),
      ),
    );
  }

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
        days = findDays(date!.month, date!.year);
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

  int? findDays(int month, int year) {
    int day2 = 0;
    if (month == 1 ||
        month == 3 ||
        month == 5 ||
        month == 7 ||
        month == 8 ||
        month == 10 ||
        month == 12) {
      return day2 = 31;
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
      return day2 = 30;
    } else {
      if (year % 4 == 0) {
        return day2 = 29;
      } else {
        return day2 = 28;
      }
    }
  }

  String? getAge() {
    DateFormat dateFormat = DateFormat('MM/dd/yyyy');
    if (date == null) {
      return null;
    } else {
      int ageYear;
      int ageMonth;
      int ageDays;
      int yearNow = initialDate.year;
      int monthNow = initialDate.month;
      int dayNow = initialDate.day;
      int birthYear = date!.year;
      int birthMonth = date!.month;
      int birthDay = date!.day;

      if (dayNow - birthDay >= 0) {
        ageDays = (dayNow - birthDay);
      } else {
        ageDays = ((dayNow + days!) - birthDay);
        monthNow = monthNow - 1;
      }
      if (monthNow - birthMonth >= 0) {
        ageMonth = (monthNow - birthMonth);
      } else {
        ageMonth = ((monthNow + 12) - birthMonth);
        yearNow = yearNow - 1;
      }
      yearNow = (yearNow - birthYear);
      ageYear = yearNow;
      return '$ageYear';
    }
  }

  void togglePasswordView() {
    isHiddenPassword = !isHiddenPassword;
    setState(() {
      viewPassword = !viewPassword;
    });
  }

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
    userModel.firstName = _firstNameEditingController.text;
    userModel.lastName = _lastNameEditingController.text;
    userModel.middleInitial = _midNameEditingController.text;
    userModel.fullName =
        '${_firstNameEditingController.text} ${_lastNameEditingController.text}';
    userModel.gender = genderValue;
    userModel.contactNumber = _contactNumberEditingController.text;
    userModel.birthday = getDate();
    userModel.age = getAge();
    userModel.bloodType = bloodTypeValue;
    userModel.street = _streetEditingController.text;
    userModel.brgy = _brgyEditingController.text;
    userModel.municipality = municipalityValue;
    userModel.province = provinceValue;
    userModel.visibility = 'No';
    userModel.status = 'online';

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
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                          primary: Color(0xffcc021d))),
                                  child: Stepper(
                                    elevation: 0,
                                    //margin:
                                    //  EdgeInsets.symmetric(horizontal: 10),
                                    currentStep: currentStepIndex,
                                    type: StepperType.horizontal,
                                    onStepContinue: () async {
                                      if (currentStepIndex != 2) {
                                        currentStepIndex += 1;
                                        setState(() {});
                                      } else if (currentStepIndex == 2 &&
                                          isChecked == true) {
                                        final SharedPreferences
                                            sharedPreferences =
                                            await SharedPreferences
                                                .getInstance();
                                        sharedPreferences.setString('email',
                                            _emailEditingController.text);
                                        signUp(_emailEditingController.text,
                                            _passwordEditingController.text);
                                        setState(() {});
                                      }
                                    },
                                    onStepCancel: () {
                                      if (currentStepIndex != 0) {
                                        currentStepIndex -= 1;
                                        setState(() {});
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
                                                  'Email',
                                                  _emailEditingController,
                                                  'emailValidator',
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  45.0),
                                              const SizedBox(height: 10.0),
                                              textFormPassword(
                                                  'Password',
                                                  Icon(
                                                      viewPassword
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                                      size: 20.0,
                                                      color: Colors.grey[400]),
                                                  _passwordEditingController,
                                                  'passwordValidator',
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  45.0),
                                              const SizedBox(height: 10.0),
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
                                                  Expanded(
                                                    flex: 1,
                                                    child: textForm(
                                                        'Middle Initial',
                                                        _midNameEditingController,
                                                        'null',
                                                        136.0,
                                                        45.0),
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: 45,
                                                      width: 136,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 12,
                                                          vertical: 4),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                              width: 0.5)),
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton<
                                                                String>(
                                                            icon: const Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                              size: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            hint: const Text(
                                                              'Sex',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'PoppinsRegular',
                                                                  letterSpacing:
                                                                      1.5,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      12.0),
                                                            ),
                                                            value: genderValue,
                                                            isExpanded: true,
                                                            items: genderList
                                                                .map(
                                                                    buildMenuItem)
                                                                .toList(),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                genderValue =
                                                                    value;
                                                              });
                                                            }),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                height: 45,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 0.5)),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                      icon: const Icon(
                                                        Icons.arrow_drop_down,
                                                        size: 20,
                                                        color: Colors.black,
                                                      ),
                                                      hint: const Text(
                                                        'Blood Type',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'PoppinsRegular',
                                                            letterSpacing: 1.5,
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                            fontSize: 12.0),
                                                      ),
                                                      value: bloodTypeValue,
                                                      isExpanded: true,
                                                      items: bloodTypeList
                                                          .map(buildMenuItem)
                                                          .toList(),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          bloodTypeValue =
                                                              value;
                                                        });
                                                      }),
                                                ),
                                              ),
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
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
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
                                                Container(
                                                  height: 45,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 0.5)),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton<
                                                            String>(
                                                        icon: const Icon(
                                                          Icons.arrow_drop_down,
                                                          size: 20,
                                                          color: Colors.black,
                                                        ),
                                                        hint: const Text(
                                                          'Municipality',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'PoppinsRegular',
                                                              letterSpacing:
                                                                  1.5,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12.0),
                                                        ),
                                                        value:
                                                            municipalityValue,
                                                        isExpanded: true,
                                                        items: municipalityList
                                                            .map(buildMenuItem)
                                                            .toList(),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            municipalityValue =
                                                                value;
                                                          });
                                                        }),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                Container(
                                                  height: 45,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 0.5)),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton<
                                                            String>(
                                                        icon: const Icon(
                                                          Icons.arrow_drop_down,
                                                          size: 20,
                                                          color: Colors.black,
                                                        ),
                                                        hint: const Text(
                                                          'Province',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'PoppinsRegular',
                                                              letterSpacing:
                                                                  1.5,
                                                              color: Color
                                                                  .fromRGBO(0,
                                                                      0, 0, 1),
                                                              fontSize: 12.0),
                                                        ),
                                                        value: provinceValue,
                                                        isExpanded: true,
                                                        items: provinceList
                                                            .map(buildMenuItem)
                                                            .toList(),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            provinceValue =
                                                                value;
                                                          });
                                                        }),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
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
                                                            color:
                                                                Colors.black),
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
                                                contactNumberForm(
                                                    'ex. 9xxxxxxxxx ',
                                                    _contactNumberEditingController,
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    65.0),
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
                                                  'Email: ${_emailEditingController.text}',
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
                                                  'Password: ${_passwordEditingController.text}',
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
                                              Text('Sex: $genderValue',
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
                                                  'Blood Type: $bloodTypeValue',
                                                  style: const TextStyle(
                                                    fontSize: 15.0,
                                                    fontFamily:
                                                        'PoppinsRegular',
                                                    letterSpacing: 1.5,
                                                    color: Colors.black,
                                                  )),
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
                                              Text('Age: ${getAge()}',
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
                                                  'Address: ${_streetEditingController.text} ${_brgyEditingController.text} $municipalityValue, $provinceValue',
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

  Widget textForm(String labelText, TextEditingController controller,
      String validator, double width, double height) {
    const String firstNameValidator = 'firstNameValidator';
    const String lastNameValidator = 'lastNameValidator';
    const String emailValidator = 'emailValidator';
    const String streetValidator = 'streetAndBrgyValidator';
    const String brgyValidator = 'streetAndBrgyValidator';

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
            RegExp regex = RegExp(r'^.{2,}$');
            if (value!.isEmpty) {
              return ("First name is required");
            }
            if (!regex.hasMatch(value)) {
              return ("Enter valid first name(Min. 2 Characters)");
            }
            return null;
          }
          if (lastNameValidator == validator) {
            RegExp regex = RegExp(r'^.{2,}$');
            if (value!.isEmpty) {
              return ("Last name is required");
            }
            if (!regex.hasMatch(value)) {
              return ("Enter valid last name(Min. 2 Characters)");
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
          labelStyle: const TextStyle(
            fontSize: 12.0,
            color: Colors.black,
            fontFamily: 'PoppinsRegular',
            letterSpacing: 1.5,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 1.5, color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 1, color: Colors.black),
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
        autofocus: false,
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
          return null;
        },
        obscureText: isHiddenPassword,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          labelText: labelText,
          suffixIcon: InkWell(child: icon, onTap: togglePasswordView),
          fillColor: Colors.white,
          filled: true,
          labelStyle: const TextStyle(
            fontSize: 12.0,
            color: Colors.black,
            fontFamily: 'PoppinsRegular',
            letterSpacing: 1.5,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 1.5, color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(width: 1, color: Colors.black)),
        ),
      ),
    );
  }

  Widget contactNumberForm(String hintText, TextEditingController controller,
      double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        autofocus: false,
        controller: controller,
        keyboardType: TextInputType.number,
        maxLength: 10,
        onSaved: (value) {
          controller.text = value!;
        },
        validator: (value) {
          RegExp regex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
          if (value!.isEmpty) {
            return ("Contact number is required");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Phone Number");
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 3),
            child: Text(
              ' (+63) ',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black,
                fontFamily: 'PoppinsRegular',
                letterSpacing: 1.5,
              ),
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          hintStyle: const TextStyle(
            fontSize: 15.0,
            color: Colors.grey,
            fontFamily: 'PoppinsRegular',
            letterSpacing: 1.5,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 1.5, color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 1, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
