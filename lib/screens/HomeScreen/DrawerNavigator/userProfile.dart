import 'dart:io';

import 'package:bcons_app/model/user_model.dart';
import 'package:bcons_app/screens/HomeScreen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NewUserProfile extends StatefulWidget {
  const NewUserProfile({Key? key}) : super(key: key);

  @override
  _NewUserProfileState createState() => _NewUserProfileState();
}

class _NewUserProfileState extends State<NewUserProfile> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final firebase_auth.FirebaseAuth firebaseAuth =
      firebase_auth.FirebaseAuth.instance;
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;

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

  bool edit = false;
  final _formkey = GlobalKey<FormState>();
  final _emailEditingController = TextEditingController();
  final _firstNameEditingController = TextEditingController();
  final _lastNameEditingController = TextEditingController();
  final _midNameEditingController = TextEditingController();
  final _genderEditingController = TextEditingController();
  final _contactNumberEditingController = TextEditingController();
  final _streetEditingController = TextEditingController();
  final _brgyEditingController = TextEditingController();
  final _municipalityEditingController = TextEditingController();
  final _provinceEditingController = TextEditingController();

  bool isPhotoAlbumClick = false;
  String imageUrl = '';
  String collectionName = 'Users';
  XFile? imagePath;
  final ImagePicker picker = ImagePicker();

  imagePicker() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image;
      });
    }
  }

  uploadImage() async {
    var uniqueKey = firestoreRef.collection(collectionName).doc(user!.uid);
    String uploadFileName =
        DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";
    Reference reference =
        storageRef.ref().child(collectionName).child(uploadFileName);
    UploadTask uploadTask = reference.putFile(File(imagePath!.path));

    uploadTask.snapshotEvents.listen((event) {
      print(event.bytesTransferred.toString() +
          '\t' +
          event.totalBytes.toString());
    });

    await uploadTask.whenComplete(() async {
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
      if (uploadPath.isNotEmpty) {
        firestoreRef.collection(collectionName).doc(uniqueKey.id).set({
          'image': uploadPath,
          'uid': loggedInUser.uid,
          'email': loggedInUser.email,
          'firstName': loggedInUser.firstName,
          'lastName': loggedInUser.lastName,
          'middleInitial': loggedInUser.middleInitial,
          'gender': loggedInUser.gender,
          'contactNumber': loggedInUser.contactNumber,
          'birthday': loggedInUser.birthday,
          'age': loggedInUser.age,
          'street': loggedInUser.street,
          'brgy': loggedInUser.brgy,
          'municipality': loggedInUser.municipality,
          'province': loggedInUser.province
        }).then((value) => showMessage('Record Inserted'));
      } else {
        showMessage('Something while uploading Image');
      }
      setState(() {
        imageUrl = uploadPath;
        loggedInUser.image = imageUrl;
      });
    });
  }

  showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 3),
    ));
  }

  void updateUserInstance() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebase_auth.User? user = firebaseAuth.currentUser;

    UserModel userModel = UserModel();

    //writing all the values
    userModel.uid = user!.uid;
    userModel.email = user.email;
    userModel.firstName = _firstNameEditingController.text;
    userModel.lastName = _lastNameEditingController.text;
    userModel.middleInitial = _midNameEditingController.text;
    userModel.gender = _genderEditingController.text;
    userModel.contactNumber = _contactNumberEditingController.text;
    userModel.birthday = loggedInUser.birthday;
    userModel.age = loggedInUser.age;
    userModel.street = _streetEditingController.text;
    userModel.brgy = _brgyEditingController.text;
    userModel.municipality = _municipalityEditingController.text;
    userModel.province = _provinceEditingController.text;

    try {
      firebaseFirestore
          .collection('Users')
          .doc(user.uid)
          .update(userModel.toMap());
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const NewUserProfile()));
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Profile',
          style: TextStyle(
              fontFamily: 'PoppinsBold',
              letterSpacing: 2.0,
              color: Colors.white,
              fontSize: 20.0),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: const Color(0xffcc021d),
        leading: InkWell(
            child: const Icon(
              Icons.arrow_back,
            ),
            onTap: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()))),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  color: const Color(0xffd90824),
                  height: 210.0,
                  width: double.infinity,
                ),
                (loggedInUser.image == null)
                    ? const Positioned(
                        top: 100.0,
                        child: CircleAvatar(
                          radius: 87.0,
                          backgroundColor: Color(0xffcc021d),
                          child: CircleAvatar(
                            radius: 80.0,
                            backgroundColor: Color(0xffd90824),
                            backgroundImage: AssetImage(
                                'assets/images/BCONS_screen_.icon.png'),
                          ),
                        ),
                      )
                    : Positioned(
                        top: 100.0,
                        child: CircleAvatar(
                          radius: 87.0,
                          backgroundColor: const Color(0xffcc021d),
                          child: CircleAvatar(
                              radius: 80.0,
                              backgroundColor: const Color(0xffd90824),
                              backgroundImage:
                                  NetworkImage('${loggedInUser.image}')),
                        ),
                      ),
                Positioned(
                  right: 30.0,
                  top: 20.0,
                  child: InkWell(
                    onTap: () {
                      bottomModalSheet(context);
                      setState(() {
                        edit = true;
                      });
                    },
                    child: Icon(Icons.edit,
                        size: 35.0, color: edit ? Colors.blue : Colors.white),
                  ),
                ),
                const Positioned(
                  left: 30.0,
                  top: 30.0,
                  child: Text(
                    'Name',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ),
                Positioned(
                  left: 30.0,
                  top: 50.0,
                  child: loggedInUser.middleInitial!.isNotEmpty
                      ? Text(
                          '${loggedInUser.firstName} ${loggedInUser.middleInitial}. ${loggedInUser.lastName}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              letterSpacing: 2.0,
                              fontFamily: 'PoppinsBold'),
                        )
                      : Text(
                          '${loggedInUser.firstName} ${loggedInUser.lastName}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              letterSpacing: 2.0,
                              fontFamily: 'PoppinsBold'),
                        ),
                ),
                const SizedBox(
                  height: 220.0,
                ),
                Positioned(
                    right: 10.0,
                    top: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        imagePicker();
                        setState(() {
                          isPhotoAlbumClick = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        fixedSize: const Size(100, 20.0),
                      ),
                      child: const Text(
                        'Select',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            letterSpacing: 1.5,
                            fontFamily: 'PoppinsRegular'),
                      ),
                    )),
                isPhotoAlbumClick
                    ? Positioned(
                        right: 10.0,
                        top: 160,
                        child: ElevatedButton(
                          onPressed: () {
                            uploadImage();
                            setState(() {
                              isPhotoAlbumClick = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            fixedSize: const Size(100, 20.0),
                          ),
                          child: const Text(
                            'Upload',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                letterSpacing: 1.5,
                                fontFamily: 'PoppinsRegular'),
                          ),
                        ))
                    : Container(),
                const Positioned(
                  left: 30.0,
                  bottom: -110.0,
                  child: Text(
                    'Mobile Number',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ),
                Positioned(
                  left: 30.0,
                  bottom: -135.0,
                  child: Text(
                    '+63${loggedInUser.contactNumber}',
                    style: const TextStyle(
                        color: Color(0xffd90824),
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ),
                const Positioned(
                  right: 80.0,
                  bottom: -110.0,
                  child: Text(
                    'Sex',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ),
                Positioned(
                  right: 65.0,
                  bottom: -135.0,
                  child: Text(
                    '${loggedInUser.gender}',
                    style: const TextStyle(
                        color: Color(0xffd90824),
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ),
                const Positioned(
                  left: 30.0,
                  bottom: -180.0,
                  child: Text(
                    'Email',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ),
                Positioned(
                  left: 30.0,
                  bottom: -205.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${loggedInUser.email}',
                        style: const TextStyle(
                            color: Color(0xffd90824),
                            fontSize: 15.0,
                            letterSpacing: 2.0,
                            fontFamily: 'PoppinsBold'),
                      )
                    ],
                  ),
                ),
                const Positioned(
                  left: 30.0,
                  bottom: -240.0,
                  child: Text(
                    'Birthday',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ),
                Positioned(
                  left: 30.0,
                  bottom: -265.0,
                  child: Text(
                    '${loggedInUser.birthday}',
                    style: const TextStyle(
                        color: Color(0xffd90824),
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ),
                const Positioned(
                  right: 80.0,
                  bottom: -240.0,
                  child: Text(
                    'Age',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ),
                Positioned(
                  right: 93.0,
                  bottom: -265.0,
                  child: Text(
                    '${loggedInUser.age}',
                    style: const TextStyle(
                        color: Color(0xffd90824),
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ),
                const Positioned(
                  left: 30.0,
                  bottom: -310.0,
                  child: Text(
                    'Address',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ),
                Positioned(
                  left: 30.0,
                  bottom: -335.0,
                  child: Text(
                    '${loggedInUser.street} ${loggedInUser.brgy}',
                    style: const TextStyle(
                        color: Color(0xffd90824),
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ),
                Positioned(
                  left: 30.0,
                  bottom: -355.0,
                  child: Text(
                    '${loggedInUser.municipality}, ${loggedInUser.province}',
                    style: const TextStyle(
                        color: Color(0xffd90824),
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ),
                const Positioned(
                  right: 13.0,
                  bottom: -310.0,
                  child: Text(
                    'Blood Type',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ),
                Positioned(
                  right: 95.0,
                  bottom: -335.0,
                  child: Text(
                    '${loggedInUser.bloodType}',
                    style: const TextStyle(
                        color: Color(0xffd90824),
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future bottomModalSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Edit Profile',
                        style: TextStyle(
                            fontFamily: 'PoppinsBold',
                            letterSpacing: 2.0,
                            color: Colors.black,
                            fontSize: 20.0),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      textForm('${loggedInUser.email}', _emailEditingController,
                          MediaQuery.of(context).size.width, 45),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: textForm(
                                '${loggedInUser.lastName}',
                                _lastNameEditingController,
                                MediaQuery.of(context).size.width,
                                45),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: textForm(
                                '${loggedInUser.firstName}',
                                _firstNameEditingController,
                                MediaQuery.of(context).size.width,
                                45),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 1,
                            child: textForm(
                                '${loggedInUser.middleInitial}',
                                _midNameEditingController,
                                MediaQuery.of(context).size.width,
                                45),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: textForm(
                                '${loggedInUser.gender}',
                                _genderEditingController,
                                MediaQuery.of(context).size.width,
                                45),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: contactNumberForm(
                                '+63${loggedInUser.contactNumber}',
                                _contactNumberEditingController,
                                MediaQuery.of(context).size.width,
                                45),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      textForm(
                          '${loggedInUser.street}',
                          _streetEditingController,
                          MediaQuery.of(context).size.width,
                          45),
                      const SizedBox(
                        height: 10,
                      ),
                      textForm('${loggedInUser.brgy}', _brgyEditingController,
                          MediaQuery.of(context).size.width, 45),
                      const SizedBox(
                        height: 10,
                      ),
                      textForm(
                          '${loggedInUser.municipality}',
                          _municipalityEditingController,
                          MediaQuery.of(context).size.width,
                          45),
                      const SizedBox(
                        height: 10,
                      ),
                      textForm(
                          '${loggedInUser.province}',
                          _provinceEditingController,
                          MediaQuery.of(context).size.width,
                          45),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          updateUserInstance();
                          setState(() {
                            edit = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          fixedSize: const Size(100, 50.0),
                          primary: const Color(0xffcc021d),
                        ),
                        child: const Text(
                          'Save',
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
                ),
              ),
            ),
          );
        });
  }

  Widget textForm(String hintText, TextEditingController controller,
      double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        autofocus: false,
        controller: controller,
        onSaved: (value) {
          controller.text = value!;
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
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

  Widget contactNumberForm(String hintText, TextEditingController controller,
      double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        autofocus: false,
        controller: controller,
        onSaved: (value) {
          controller.text = value!;
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
          hintStyle: TextStyle(
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
}
