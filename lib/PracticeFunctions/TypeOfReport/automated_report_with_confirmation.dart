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
import 'package:tflite/tflite.dart';

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
  List outputs = [];
  String confidence = '';
  String name = '';
  String numbers = '';

  imagePickerFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = image;
        print(pickedImage!.path);
        isImageLoading = true;
      });
    }
    classifyImage(pickedImage!);
  }

  imagePickerFromCamera() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        pickedImage = image;
        print(pickedImage!.path);
        isImageLoading = true;
      });
    }
    classifyImage(pickedImage!);
  }

  void loadModel() async {
    var resultant = await Tflite.loadModel(
        labels: 'assets/labels1.txt', model: 'assets/tunedmodel13.tflite');
    print('$resultant');
  }

  classifyImage(XFile image) async {
    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 117.0, // defaults to 117.0
        imageStd: 1, // defaults to 1.0
        numResults: 4, // defaults to 5
        threshold: 0.5, // defaults to 0.1
        asynch: true // defaults to true
        );

    print('$recognitions');
    setState(() {
      outputs = recognitions!;
      String str = outputs[0]['label'];

      name = str.substring(2);
      confidence = outputs.isNotEmpty
          ? (outputs[0]['confidence'] * 100.0).toString().substring(0, 2) + '%'
          : '';
    });
  }

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
              '${loggedInUser.firstName} ${loggedInUser.middleInitial} ${loggedInUser.lastName}';
          map['age'] = '${loggedInUser.age}';
          map['sex'] = '${loggedInUser.gender}';
          map['date'] = DateFormat("yyyy-MM-dd").format(initialDate);
          map['time'] = DateFormat("hh:mm:ss").format(initialDate);
          //map['emergencyTypeOfReport'] = emergencyValue;
          //map['description'] = _additionalInfoEditingController.text;
          map['image'] = uploadPath;
          map['description'] = '';
          map['emergencyTypeOfReport'] = name;
          map['address'] = loggedInUser.address;
          map['latitude'] = loggedInUser.latitude;
          map['longitude'] = loggedInUser.longitude;
          map['contactNumber'] = '+63${loggedInUser.contactNumber}';
          map['status'] = 'unsolved';
          //map['sendToNearbyUsers'] = sendToNearbyUsers;
          map['autoOrManual'] = 'manual';
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
              'emergencyTypeOfReport': name,
              'bloodType': '${loggedInUser.bloodType}',
              'status': 'unsolved',
              'description': '',
              'autoOrManual': 'automated',
              'contactNumber': '+63${loggedInUser.contactNumber}',
              'name':
                  '${loggedInUser.firstName} ${loggedInUser.middleInitial} ${loggedInUser.lastName}',
              'age': '${loggedInUser.age}',
              'sex': '${loggedInUser.gender}',
              'date': DateFormat("yyyy-MM-dd").format(initialDate),
              'time': DateFormat("hh:mm:ss").format(initialDate),
              //  'emergencyTypeOfReport': emergencyValue,
              //  'description': _additionalInfoEditingController.text,
              'image': uploadPath,
              'address': loggedInUser.address,
              'longitude': loggedInUser.longitude,
              'latitude': loggedInUser.latitude,
              //'sendToNearbyUsers': sendToNearbyUsers,
              'municipalityReport': '${loggedInUser.liveMunicipality}',
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
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  void initState() {
    super.initState();
    loadModel();
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
          leading: InkWell(
            child: const Icon(
              Icons.arrow_back,
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            isImageLoading
                ? Container(
                    height: 350,
                    width: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                            image: FileImage(File(pickedImage!.path)),
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.low)))
                : Container(),
            const SizedBox(
              height: 10,
            ),
            (isImageLoading == true)
                ? outputs.isNotEmpty
                    ? Column(
                        children: [
                          Text(
                            'The image detected was $name',
                            style: const TextStyle(
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 1.5,
                                color: Colors.black,
                                fontSize: 15.0),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'If the image you provided is not the desired image, please capture another image on another angle.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 1.5,
                                color: Colors.black,
                                fontSize: 12.0),
                          ),
                        ],
                      )
                    : const CircularProgressIndicator()
                : Container()
          ]),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor:
                isImageLoading == true ? const Color(0xffd90824) : Colors.grey,
            child: const Text(
              'Done',
              style: TextStyle(
                  fontFamily: 'PoppinsRegular',
                  letterSpacing: 1.5,
                  color: Colors.white,
                  fontSize: 15.0),
            ),
            onPressed: isImageLoading == true ? showSheet : () {}),
        persistentFooterButtons: [
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        imagePickerFromCamera();
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        size: 30,
                      )),
                  SizedBox(
                    width: 25,
                  ),
                  IconButton(
                      onPressed: () {
                        imagePickerFromGallery();
                      },
                      icon: Icon(
                        Icons.image_outlined,
                        size: 30,
                        color: Colors.black,
                      )),
                ],
              ))
        ]);
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
            'Location in Maps: ${loggedInUser.latitude}, ${loggedInUser.longitude}',
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
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              name,
              style: const TextStyle(
                  fontFamily: 'PoppinsRegular',
                  letterSpacing: 1.5,
                  color: Colors.white,
                  fontSize: 15.0),
            ),
          ),
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
