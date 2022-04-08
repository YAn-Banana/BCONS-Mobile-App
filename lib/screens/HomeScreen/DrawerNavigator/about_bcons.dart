import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/about_us.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/our_team.dart';

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
              children: [
                Text(
                  'About',
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      fontFamily: 'PoppinsBold'),
                ),
                const Text(
                  'BCONS',
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
            child: Column(children: [
              const Divider(
                height: 5.0,
                color: Color(0xffd90824),
                thickness: 3.0,
                endIndent: 300,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Bulakan Collaborative Network for Safety (BCONS) is an application that will make citizens feel more secure and prepared. Prior to and during an emergency or accident, BCONS provides much-needed assistance, insights, and community awareness.',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    letterSpacing: 2.0,
                    fontFamily: 'PoppinsRegular'),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info,
                          size: 25.0,
                          color: Color(0xffd90824),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AboutUs()));
                            });
                          },
                          child: const Text(
                            'About Us',
                            style: TextStyle(
                              color: Color(0xffd90824),
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'PoppinsRegular',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 80.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.group,
                                size: 25,
                                color: Color(0xffd90824),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const OurTeam()));
                                  });
                                },
                                child: const Text(
                                  'Our Team',
                                  style: TextStyle(
                                    color: Color(0xffd90824),
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'PoppinsRegular',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
