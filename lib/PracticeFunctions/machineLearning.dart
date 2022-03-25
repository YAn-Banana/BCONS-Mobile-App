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
  final ImagePicker picker = ImagePicker();
  List outputs = [];
  String confidence = '';
  String name = '';
  String numbers = '';

  imagePicker() async {
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

  void loadModel() async {
    var resultant = await Tflite.loadModel(
        labels: 'assets/labels1.txt', model: 'assets/model3.tflite');
    print('$resultant');
  }

  classifyImage(XFile image) async {
    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 117, // defaults to 117.0
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          isImageLoading
              ? Container(
                  height: 350,
                  width: 350,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(File(pickedImage!.path)))))
              : Container(),
          const SizedBox(
            height: 10,
          ),
          Text('Name: $name \n Confidence: $confidence'),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.picture_in_picture_rounded),
          onPressed: () {
            imagePicker();
          }),
    );
  }
}
