import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:bcons_app/model/user_model.dart';
import 'package:bcons_app/screens/HomeScreen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CreatePDF extends StatefulWidget {
  const CreatePDF({Key? key}) : super(key: key);

  @override
  State<CreatePDF> createState() => _CreatePDFState();
}

class _CreatePDFState extends State<CreatePDF> {
  XFile? pickedImage;
  bool isImageLoading = false;
  final ImagePicker picker = ImagePicker();
  String imageUrl = '';

  final pdf = pw.Document();
  DateTime initialDate = DateTime.now();
  String pdfURL = '';

  final _formkey = GlobalKey<FormState>();
  final _additionalInfoEditingController = TextEditingController();
  String? emergencyValue;
  final emergencyClass = [
    'Accident',
    'Crime',
    'Earthquake',
    'Fire',
    'Flood',
    'Health Emergency',
  ];

  DropdownMenuItem<String> buildMenuItem(String emergency) {
    return DropdownMenuItem(
      value: emergency,
      child: Text(
        emergency,
        style: const TextStyle(
            fontFamily: 'PoppinsRegular',
            letterSpacing: 1.5,
            color: Color.fromRGBO(0, 0, 0, 1),
            fontSize: 20.0),
      ),
    );
  }

  imagePicker() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = image;
        isImageLoading = true;
      });
    }
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
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
            'Manual Report',
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
                  uploadImagetoFirebaseStorageAndUploadTheReportDetailsOfUserInDatabase();
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
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isImageLoading
                        ? Center(
                            child: Container(
                                height: 150,
                                width: 200,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(
                                            File(pickedImage!.path))))),
                          )
                        : Container(),
                    const SizedBox(height: 10.0),
                    const Text(
                      'What kind of emergency are you going to report?',
                      style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          letterSpacing: 1.5,
                          color: Colors.black,
                          fontSize: 20.0),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black, width: 1)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              size: 20,
                              color: Colors.black,
                            ),
                            value: emergencyValue,
                            isExpanded: true,
                            items: emergencyClass.map(buildMenuItem).toList(),
                            onChanged: (value) {
                              setState(() {
                                emergencyValue = value;
                              });
                            }),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Additional Information',
                      style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          letterSpacing: 1.5,
                          color: Colors.black,
                          fontSize: 20.0),
                    ),
                    const SizedBox(height: 10.0),
                    textForm('Description', _additionalInfoEditingController,
                        MediaQuery.of(context).size.width, 100)
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.picture_in_picture_rounded),
            onPressed: imagePicker));
  }

  uploadImagetoFirebaseStorageAndUploadTheReportDetailsOfUserInDatabase() async {
    FirebaseStorage storageRef = FirebaseStorage.instance;
    String uploadFileName =
        '${loggedInUser.uid},${DateFormat("yyyy-MM-dd,hh:mm:ss").format(initialDate)}.jpg';
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
          DatabaseReference database = FirebaseDatabase.instance
              .ref()
              .child('User\'s Report')
              .child('${loggedInUser.uid}');
          String? uploadId = database.push().key;

          HashMap map = HashMap();
          map['email'] = '${loggedInUser.email}';
          map['name'] =
              '${loggedInUser.lastName}, ${loggedInUser.firstName} ${loggedInUser.middleInitial}';
          map['date and time'] =
              DateFormat("yyyy-MM-dd,hh:mm:ss").format(initialDate);
          map['emergency type of report'] = emergencyValue;
          map['description'] = _additionalInfoEditingController.text;
          map['image'] = uploadPath;
          map['address'] = loggedInUser.address;
          map['location'] = loggedInUser.location;
          map['solved or unsolved'] = 'unsolved';
          database.child(uploadId!).set(map).whenComplete(
                () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => const HomeScreen()),
                    (route) => false),
              );
          showSnackBar(context, 'Completely Reported');
        } catch (e) {
          showSnackBar(context, e.toString());
        }
      }
    });
  }

/*
  Future<void> createPdf() async {
    final image = pw.MemoryImage(File(pickedImage!.path).readAsBytesSync());
    pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Name:',
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    '${loggedInUser.lastName}, ${loggedInUser.firstName} ${loggedInUser.middleInitial}',
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                  pw.Text(
                    'Age:',
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    '${loggedInUser.age}',
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Sex:',
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    '${loggedInUser.gender}',
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Location:',
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    '${loggedInUser.street} ${loggedInUser.brgy} ${loggedInUser.municipality}, ${loggedInUser.province}',
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Emergency Details:',
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    emergencyValue.toString(),
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Additional Information: ',
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    _additionalInfoEditingController.text,
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Date and Time:',
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                  pw.Text(
                    DateFormat("yyyy-MM-dd hh:mm:ss").format(initialDate),
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                ]); // Center
          }),
    );
    pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(image),
            ); // Center
          }),
    );
  }
  */
  /* Future<void> savePdf() async {
    String time = DateFormat("hh:mm:ss").format(initialDate);
    try {
      final dir = await getExternalStorageDirectory();
      final file = File('${dir!.path}/example$time.pdf');
      await file.writeAsBytes(await pdf.save());

      firebase_storage.UploadTask task = await uploadFile(file);

      print(task.snapshot.ref.getDownloadURL());

      showSnackBar(context, "Saved to documents $file");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const HomeScreen()),
          (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
*/
  Future<void> storeToRealTimeDatabase() async {
    DatabaseReference database = FirebaseDatabase.instance
        .ref()
        .child('User\'s Report')
        .child('${loggedInUser.uid}');
    String? uploadId = database.push().key;

    HashMap map = HashMap();
    map['email'] = '${loggedInUser.email}';
    map['name'] =
        '${loggedInUser.lastName}, ${loggedInUser.firstName} ${loggedInUser.middleInitial}';
    map['date and time'] =
        DateFormat("yyyy-MM-dd,hh:mm:ss").format(initialDate);
    map['emergency type of report'] = emergencyValue;
    map['description'] = _additionalInfoEditingController.text;
    map['image'] = imageUrl;
    map['address'] = loggedInUser.address;
    map['location'] = loggedInUser.location;
    database.child(uploadId!).set(map).whenComplete(() =>
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => const HomeScreen()),
            (route) => false));
  }

  /*Future<firebase_storage.UploadTask> uploadFile(File file) async {
    firebase_storage.UploadTask uploadTask;
    String time = DateFormat("hh:mm:ss").format(initialDate);

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users\' Report')
        .child('/${loggedInUser.uid}-$time.pdf');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'file/pdf',
        customMetadata: {'picked-file-path': file.path});

    print("Uploading..!");

    uploadTask = ref.putData(await file.readAsBytes(), metadata);
    var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
    setState(() {
      pdfURL = uploadPath;
    });
    print("done..!");

    

    return Future.value(uploadTask);
  }
  */
  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget textForm(String label, TextEditingController controller, double width,
      double height) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        child: TextFormField(
          autofocus: false,
          controller: controller,
          maxLines: 3,
          textAlign: TextAlign.start,
          onSaved: (value) {
            controller.text = value!;
          },
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            label: Text(label),
            fillColor: Colors.white,
            filled: true,
            labelStyle: const TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontFamily: 'PoppinsRegular',
              letterSpacing: 1.5,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(width: 1, color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(width: 1.0, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
