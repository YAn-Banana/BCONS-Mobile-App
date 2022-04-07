import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 30.0),
            color: const Color(0xffd90824),
            height: 150.0,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'About Us',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      fontFamily: 'PoppinsBold'),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 20.0),
              child: Column(
                children: const [
                  Divider(
                    height: 5.0,
                    color: Color(0xffd90824),
                    thickness: 3.0,
                    endIndent: 300,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'We are a group of programmers and developers from Bulacan State University who want to improve the efficiency of communication and medical services in emergency times.',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsRegular'),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
