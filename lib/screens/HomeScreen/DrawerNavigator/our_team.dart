import 'package:flutter/material.dart';

class OurTeam extends StatefulWidget {
  const OurTeam({Key? key}) : super(key: key);

  @override
  _OurTeamState createState() => _OurTeamState();
}

class _OurTeamState extends State<OurTeam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Our Team',
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
        child: ListView(
          shrinkWrap: true,
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
                    'Meet the entire Team!',
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 15.0,
                        letterSpacing: 1.5,
                        fontFamily: 'PoppinsBold'),
                  ),
                  const Text(
                    'Our Team',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsBold'),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: memberCard('Borlagdatan,', 'Floryan H.',
                          'floryan.JPG', 'Student'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: memberCard(
                          'Frondoso,', 'Mark Angelo', 'fronds.jpg', 'Student'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: memberCard('Morales,', 'Steven Austin R.',
                          'steven.jpg', 'Student'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: memberCard(
                          'Pagsanjan,', 'Archie R.', 'archie.jpeg', 'Student'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: memberCard('Palacio,', 'Marc Adriene M.',
                          'adriene.jpg', 'Student'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: memberCard(
                          'Prado,', 'Joseph H.', 'joseph.JPG', 'Student'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: memberCard(
                          'Sacdalan,', 'Ryan Christian', 'ryan.png', 'Student'),
                    ),
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget memberCard(
      String lastName, String firstName, String imageUrl, String descriptions) {
    return SizedBox(
      height: 248,
      width: 248,
      child: Column(children: [
        Text(
          lastName,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              letterSpacing: 1.5,
              fontFamily: 'PoppinsBold'),
        ),
        Text(
          firstName,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              letterSpacing: 1.5,
              fontFamily: 'PoppinsRegular'),
        ),
        const SizedBox(
          height: 5,
        ),
        CircleAvatar(
          radius: 80.0,
          backgroundImage: AssetImage('assets/images/$imageUrl'),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          descriptions,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 12.0,
              letterSpacing: 1.5,
              fontFamily: 'PoppinsRegular'),
        ),
      ]),
    );
  }
}
