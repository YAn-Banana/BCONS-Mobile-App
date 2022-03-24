import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:bcons_app/model/user_model.dart';
import 'package:bcons_app/screens/HomeScreen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AutomatedReport extends StatefulWidget {
  const AutomatedReport({Key? key}) : super(key: key);

  @override
  State<AutomatedReport> createState() => _AutomatedReportState();
}

class _AutomatedReportState extends State<AutomatedReport> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  DateTime initialDate = DateTime.now();
  XFile? pickedImage;
  bool isImageLoading = false;
  final ImagePicker picker = ImagePicker();
  String imageUrl = '';

  uploadImagetoFirebaseStorageAndUploadTheReportDetailsOfUserInDatabase() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebase_auth.User? user = firebaseAuth.currentUser;
    FirebaseStorage storageRef = FirebaseStorage.instance;
    String uploadFileName =
        '${loggedInUser.uid},${DateFormat("yyyy-MM-dd hh:mm:ss").format(initialDate)}.jpg';
    Reference reference =
        storageRef.ref().child('User\'s Report Images').child(uploadFileName);
    UploadTask uploadTask = reference.putFile(File(pickedImage!.path));
    uploadTask.snapshotEvents.listen((event) {
      print(event.bytesTransferred.toString() +
          '\t' +
          event.totalBytes.toString());
    });
    await uploadTask.whenComplete(() async {
      String uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
      print(uploadPath);
      if (uploadPath.isNotEmpty) {
        try {
          String generateRandomString(int length) {
            final _random = Random();
            const _availableChars =
                'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
            final randomString = List.generate(
                length,
                (index) => _availableChars[
                    _random.nextInt(_availableChars.length)]).join();

            return randomString;
          }

          DatabaseReference database = FirebaseDatabase.instance
              .ref()
              .child('User\'s Report')
              .child(user!.uid);
          String? uploadId =
              database.child('User\'s Report').child(user.uid).push().key;

          HashMap map = HashMap();
          map['email'] = '${loggedInUser.email}';
          map['name'] =
              '${loggedInUser.lastName}, ${loggedInUser.firstName} ${loggedInUser.middleInitial}';
          map['age'] = '${loggedInUser.age}';
          map['sex'] = '${loggedInUser.gender}';
          map['dateAndTime'] =
              DateFormat("yyyy-MM-dd,hh:mm:ss").format(initialDate);
          //map['emergencyTypeOfReport'] = emergencyValue;
          //map['description'] = _additionalInfoEditingController.text;
          map['image'] = uploadPath;
          map['address'] = loggedInUser.address;
          map['location'] = loggedInUser.location;
          map['solvedOrUnsolved'] = 'unsolved';
          database.child(uploadId!).set(map).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => const HomeScreen()),
                (route) => false);

            //Upload To Firestore
            firebaseFirestore
                .collection("User Reports")
                .doc(generateRandomString(20))
                .set({
              'email': '${loggedInUser.email}',
              'uid': '${loggedInUser.uid}',
              'bloodType': '${loggedInUser.bloodType}',
              'solvedOrUnsolved': 'unsolved',
              'autoOrManual': 'manual',
              'name':
                  '${loggedInUser.lastName}, ${loggedInUser.firstName} ${loggedInUser.middleInitial}',
              'age': '${loggedInUser.age}',
              'sex': '${loggedInUser.gender}',
              'dateAndTime':
                  DateFormat("yyyy-MM-dd hh:mm:ss").format(initialDate),
              //  'emergencyTypeOfReport': emergencyValue,
              //  'description': _additionalInfoEditingController.text,
              'image': uploadPath,
              'address': loggedInUser.address,
              'location': loggedInUser.location,
            });
          });
          showSnackBar(context, 'Completely Reported');
        } catch (e) {
          showSnackBar(context, e.toString());
        }
      }
    });
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Automation Report',
          style: TextStyle(
              fontFamily: 'PoppinsBold',
              letterSpacing: 2.0,
              color: Colors.white,
              fontSize: 20.0),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: const Color(0xffcc021d),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                showSheet();
              },
              child: const Icon(
                Icons.done,
                size: 30,
              ),
            ),
          )
        ],
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  Future showSheet() => showSlidingBottomSheet(context,
      builder: (context) => SlidingSheetDialog(
          cornerRadius: 16,
          avoidStatusBar: true,
          snapSpec: const SnapSpec(
            snap: true,
            initialSnap: 0.95,
            snappings: [0.4, 0.7, 0.95],
          ),
          builder: buildSheet,
          headerBuilder: headerBuilder));

  Widget headerBuilder(BuildContext context, SheetState state) {
    return Container(
      color: const Color(0xffcc021d),
      height: 30,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              width: 32,
              height: 8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSheet(context, state) {
    return Material(
      child: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height + 400,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [Colors.black, Colors.red, Colors.black])),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Center(
            child: Text(
              'REPORT DETAILS',
              style: TextStyle(
                  fontFamily: 'PoppinsBold',
                  letterSpacing: 1.5,
                  color: Colors.white,
                  fontSize: 20.0),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Time: ${DateFormat("yyyy-MM-dd hh:mm:ss").format(initialDate)}',
            style: const TextStyle(
                fontFamily: 'PoppinsRegular',
                letterSpacing: 1.5,
                color: Colors.white,
                fontSize: 15.0),
          ),
          const SizedBox(height: 10),
          Text(
            'Location in Maps: ${loggedInUser.location}',
            style: const TextStyle(
                fontFamily: 'PoppinsRegular',
                letterSpacing: 1.5,
                color: Colors.white,
                fontSize: 15.0),
          ),
          const SizedBox(height: 10),
          Text(
            'Adress: ${loggedInUser.address}',
            style: const TextStyle(
                fontFamily: 'PoppinsRegular',
                letterSpacing: 1.5,
                color: Colors.white,
                fontSize: 15.0),
          ),
          const SizedBox(height: 20),
          isImageLoading
              ? Center(
                  child: Container(
                      height: 400,
                      width: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                              image: FileImage(File(pickedImage!.path)),
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high))),
                )
              : Container(),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      fixedSize: const Size(150, 50.0),
                      primary: Colors.grey[400]),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        fontSize: 20.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    uploadImagetoFirebaseStorageAndUploadTheReportDetailsOfUserInDatabase();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    fixedSize: const Size(150, 50.0),
                    primary: const Color(0xffcc021d),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        fontSize: 20.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ),
              )
            ],
          )
        ]),
      )),
    );
  }
}
