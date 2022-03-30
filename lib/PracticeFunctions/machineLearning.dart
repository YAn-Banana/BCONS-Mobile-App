import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class MachineLearning extends StatefulWidget {
  const MachineLearning({Key? key}) : super(key: key);

  @override
  State<MachineLearning> createState() => _MachineLearningState();
}

class _MachineLearningState extends State<MachineLearning> {
  XFile? pickedImage;
  late bool isImageLoading = false;
  late bool isTextLoading = false;
  final ImagePicker picker = ImagePicker();
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

  imagePickerFromCamer() async {
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
        threshold: 0.1, // defaults to 0.1
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

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Implementation',
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
                            filterQuality: FilterQuality.high)))
                : Container(),
            const SizedBox(
              height: 10,
            ),
            (isImageLoading == true)
                ? outputs.isNotEmpty
                    ? Text('Name: $name \nConfidence: $confidence')
                    : const CircularProgressIndicator()
                : Container()
          ]),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor:
                outputs.isEmpty ? Colors.grey : const Color(0xffd90824),
            child: const Text(
              'Done',
              style: TextStyle(
                  fontFamily: 'PoppinsRegular',
                  letterSpacing: 1.5,
                  color: Colors.white,
                  fontSize: 13),
            ),
            onPressed: outputs.isEmpty ? () {} : () {}),
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
                        imagePickerFromCamer();
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        size: 30,
                      )),
                  SizedBox(
                    width: 15,
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
}
