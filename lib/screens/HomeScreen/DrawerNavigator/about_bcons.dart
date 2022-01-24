import 'package:flutter/material.dart';

class AboutBcons extends StatefulWidget {
  const AboutBcons({Key? key}) : super(key: key);

  @override
  _AboutBconsState createState() => _AboutBconsState();
}

class _AboutBconsState extends State<AboutBcons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About BCONS',
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
    );
  }
}
