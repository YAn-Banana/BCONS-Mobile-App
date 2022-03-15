import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MachineLearning extends StatefulWidget {
  const MachineLearning({Key? key}) : super(key: key);

  @override
  State<MachineLearning> createState() => _MachineLearningState();
}

class _MachineLearningState extends State<MachineLearning> {
  XFile? pickedImage;
  bool isImageLoading = false;
  final ImagePicker picker = ImagePicker();

  imagePicker() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = image;
        isImageLoading = true;
      });
    }
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          isImageLoading
              ? Container(
                  height: 350,
                  width: 350,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(File(pickedImage!.path)))))
              : Container()
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
