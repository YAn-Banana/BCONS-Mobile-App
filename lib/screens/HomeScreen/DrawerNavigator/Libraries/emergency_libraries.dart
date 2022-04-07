import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/contacts.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/user_profile.dart';
import 'package:bcons_app/screens/HomeScreen/home_screen.dart';
import 'package:flutter/material.dart';

import 'libraries_model.dart';

class Libraries extends StatefulWidget {
  const Libraries({Key? key}) : super(key: key);

  @override
  State<Libraries> createState() => _LibrariesState();
}

class _LibrariesState extends State<Libraries> {
  List<CardItem> disasterItems = [
    //Flood
    CardItem(
        image: 'assets/images/flood(1).png',
        title: 'Flood',
        description: 'Before a Flood'),
    CardItem(
        image: 'assets/images/flood(2).png',
        title: 'Flood',
        description: 'During a Flood'),
    CardItem(
        image: 'assets/images/flood(3).png',
        title: 'Flood',
        description: 'After a Flood'),
    CardItem(
        image: 'assets/images/flood(4).png',
        title: 'Flood',
        description: 'After Flood Damaged'),

    //Earthquake
    CardItem(
        image: 'assets/images/beforeEq.png',
        title: 'Earthquake',
        description: 'Before an Earthquake'),
    CardItem(
        image: 'assets/images/duringEq.png',
        title: 'Earthquake',
        description: 'During an Earthquake'),
    CardItem(
        image: 'assets/images/afterEq.png',
        title: 'Earthquake',
        description: 'After an Earthquake'),
    CardItem(
        image: 'assets/images/earthquake_tips(1).png',
        title: 'Earthquake',
        description: 'Other Tips'),

    //Fire
    CardItem(
        image: 'assets/images/beforeFire.png',
        title: 'Fire',
        description: 'Before a Fire'),
    CardItem(
        image: 'assets/images/duringFire.png',
        title: 'Fire',
        description: 'During a Fire'),
    CardItem(
        image: 'assets/images/afterFire.png',
        title: 'Fire',
        description: 'After a Fire'),

    //El Nino
    CardItem(
        image: 'assets/images/el_nino(1).png',
        title: 'El Niño',
        description: 'What is El Niño? '),
    CardItem(
        image: 'assets/images/el_nino(2).png',
        title: 'El Niño',
        description: 'What to know?'),
    CardItem(
        image: 'assets/images/el_nino(3).png',
        title: 'El Niño',
        description: 'What to do?'),

    //Storm
    CardItem(
        image: 'assets/images/storm.png',
        title: 'Storm',
        description: 'What to do?'),
  ];

  List<CardItem> healthEmergencyItems = [
    //Covid19
    CardItem(
        image: 'assets/images/Covid(1).png',
        title: 'Covid 19',
        description: 'How to prevent catching'),
    CardItem(
        image: 'assets/images/Covid(2).png',
        title: 'Covid 19',
        description: 'How to prevent spreading'),
    CardItem(
        image: 'assets/images/Covid(3).png',
        title: 'Covid 19',
        description: 'Most common symptoms'),
    CardItem(
        image: 'assets/images/Covid(4).png',
        title: 'Covid 19',
        description: 'Least common symptoms'),
    CardItem(
        image: 'assets/images/Covid(5).png',
        title: 'Covid 19',
        description: 'Serious Symptoms'),
    CardItem(
        image: 'assets/images/Covid(6).png',
        title: 'Covid 19',
        description: '5 steps to take'),

    //Shortness of Breath
    CardItem(
        image: 'assets/images/ShortnessofBreath(1).png',
        title: 'Shortness of Breath',
        description: 'Dyspnea '),
    CardItem(
        image: 'assets/images/ShortnessofBreath(2).png',
        title: 'Shortness of Breath',
        description: 'Out of breath'),
    CardItem(
        image: 'assets/images/ShortnessofBreath(3).png',
        title: 'Shortness of Breath',
        description: 'Causes'),

    //Seizure
    CardItem(
        image: 'assets/images/seizure(1).png',
        title: 'Seizure',
        description: 'First aid'),
    CardItem(
        image: 'assets/images/seizure(1).png',
        title: 'Seizure',
        description: 'When to call 911?'),
    CardItem(
        image: 'assets/images/severe_bleeding.png',
        title: 'Severe Bleeding',
        description: 'First aid'),

    //Coping with Traumatic Stress
    CardItem(
        image: 'assets/images/coping_with_traumatic_stress.png',
        title: 'Violence',
        description: 'Coping with traumatic stress'),

    //Sexual Violence
    CardItem(
        image: 'assets/images/sexual_violence_prevention.png',
        title: 'Sexual Violence',
        description: 'Stop before it starts'),

    //Physical Injuries
    CardItem(
        image: 'assets/images/PhysicalInjuries.png',
        title: 'Physical Injuries',
        description: 'Prevention Tips'),

    //Head Injuries
    CardItem(
        image: 'assets/images/HeadinjuryTips.png',
        title: 'Head Injuries',
        description: 'Prevention Tips'),

    //Mental Health
    CardItem(
        image: 'assets/images/MentalHealth.png',
        title: 'Mental Health',
        description: 'Call 911 or authorities when:'),

    //Chest Pain
    CardItem(
        image: 'assets/images/ChestPainPrevention.png',
        title: 'Chest Pain',
        description: 'How to prevent?'),
    CardItem(
        image: 'assets/images/ChestPainWhatToDo.png',
        title: 'Chest Pain',
        description: 'What to do after?'),
  ];

  List<CardItem> crimeItems = [
    CardItem(
        image: 'assets/images/AnimalBite(2).png',
        title: 'Animal Bite',
        description: 'Seek prompt medical care if:'),
    CardItem(
        image: 'assets/images/AnimalBite(1).png',
        title: 'Animal Bite',
        description: 'What to do after?'),
    CardItem(
        image: 'assets/images/CrimeRobbery(1).png',
        title: 'Robbery',
        description: 'How to prevent?'),
    CardItem(
        image: 'assets/images/CrimeRobbery(2).png',
        title: 'Robbery',
        description: 'What to do?'),
    CardItem(
        image: 'assets/images/CrimeTheft(1).png',
        title: 'Theft',
        description: 'How to prevent?'),
    CardItem(
        image: 'assets/images/CrimeTheft(2).png',
        title: 'Theft',
        description: 'What to do?'),
  ];

  List<CardItem> accidentItems = [
    //Traffic Accident
    CardItem(
        image: 'assets/images/TrafficAcc(1).png',
        title: 'Minor Accident',
        description: 'Things you must know'),
    CardItem(
        image: 'assets/images/TrafficAcc(2).png',
        title: 'Major Accident',
        description: 'Things you must know'),

    //Animal Attack
    CardItem(
        image: 'assets/images/animalattack.png',
        title: 'Animal Attack',
        description: 'How to prevent?'),

    //Drowning
    CardItem(
        image: 'assets/images/Drowning.png',
        title: 'Drowning Incident',
        description: 'What to do?'),
  ];

  List<CardItem> otherItems = [
    //Bombing Incident
    CardItem(
        image: 'assets/images/Bombing.png',
        title: 'Bombing Incident',
        description: 'Facts'),

    //Chemical Hazard
    CardItem(
        image: 'assets/images/Chemical_Hazard.png',
        title: 'Chemical Hazard',
        description: 'Facts and Types'),

    //Radiation Hazard
    CardItem(
        image: 'assets/images/Radiation.png',
        title: 'Radiation Hazard',
        description: 'Things you must know'),

    //Electrical Hazard
    CardItem(
        image: 'assets/images/Electrical.png',
        title: 'Electrical Hazard',
        description: 'Awareness'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Library',
          style: TextStyle(
              fontFamily: 'PoppinsBold',
              letterSpacing: 2.0,
              color: Colors.white,
              fontSize: 20.0),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: const Color(0xffcc021d),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [Colors.black, Colors.red, Colors.black])),
              child: Column(
                children: [
                  const Text(
                    'Disaster\'s Preparednesss Plan',
                    style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5,
                        color: Colors.white,
                        fontSize: 15.0),
                  ),
                  SizedBox(
                      height: 200,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(10),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, _) => const SizedBox(
                          width: 13,
                        ),
                        itemCount: 15,
                        itemBuilder: (context, index) =>
                            buildCard(item: disasterItems[index]),
                      )),
                  const SizedBox(height: 30),
                  const Text(
                    'Health Emergency Tips',
                    style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5,
                        color: Colors.white,
                        fontSize: 15.0),
                  ),
                  SizedBox(
                      height: 200,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(10),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, _) => const SizedBox(
                          width: 13,
                        ),
                        itemCount: 19,
                        itemBuilder: (context, index) =>
                            buildCard(item: healthEmergencyItems[index]),
                      )),
                  const SizedBox(height: 30),
                  const Text(
                    'Crime Prevention Tips',
                    style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5,
                        color: Colors.white,
                        fontSize: 15.0),
                  ),
                  SizedBox(
                      height: 200,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(10),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, _) => const SizedBox(
                          width: 13,
                        ),
                        itemCount: 6,
                        itemBuilder: (context, index) =>
                            buildCard(item: crimeItems[index]),
                      )),
                  const SizedBox(height: 30),
                  const Text(
                    'Accident Prevention Tips',
                    style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5,
                        color: Colors.white,
                        fontSize: 15.0),
                  ),
                  SizedBox(
                      height: 200,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(10),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, _) => const SizedBox(
                          width: 13,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) =>
                            buildCard(item: accidentItems[index]),
                      )),
                  const SizedBox(height: 30),
                  const Text(
                    'Other Emergency Tips',
                    style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5,
                        color: Colors.white,
                        fontSize: 15.0),
                  ),
                  SizedBox(
                      height: 200,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(10),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, _) => const SizedBox(
                          width: 13,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) =>
                            buildCard(item: otherItems[index]),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: const Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    subtitle: const Text(
                      'Home',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          letterSpacing: 1.5,
                          fontFamily: 'PoppinsRegular'),
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                          (route) => false);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: const Icon(Icons.person, color: Colors.black),
                    subtitle: const Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          letterSpacing: 1.5,
                          fontFamily: 'PoppinsRegular'),
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserProfile()),
                          (route) => false);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: const Icon(Icons.phone, color: Colors.black),
                    subtitle: const Text(
                      'Contact',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          letterSpacing: 1.5,
                          fontFamily: 'PoppinsRegular'),
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactScreen()),
                          (route) => false);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: const Icon(
                      Icons.book_outlined,
                      color: Color(0xffd90824),
                    ),
                    subtitle: const Text(
                      'Library',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xffd90824),
                          fontSize: 13.0,
                          letterSpacing: 1.5,
                          fontFamily: 'PoppinsRegular'),
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Libraries()),
                          (route) => false);
                    },
                  ),
                ),
              ],
            ))
      ],
    );
  }

  Widget buildCard({required CardItem item}) {
    return SizedBox(
      width: 250,
      child: Column(children: [
        Expanded(
            child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Material(
            child: Ink.image(
                image: AssetImage(
                  '${item.image}',
                ),
                fit: BoxFit.cover,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ModelPage(
                                  items: item,
                                ))));
                  },
                )),
          ),
        )),
        const SizedBox(
          height: 5,
        ),
        Text(
          '${item.title}',
          style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              letterSpacing: 1.5,
              fontFamily: 'PoppinsBold'),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          '${item.description}',
          style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              letterSpacing: 1.5,
              fontFamily: 'PoppinsRegular'),
        ),
      ]),
    );
  }
}

class ModelPage extends StatelessWidget {
  final CardItem items;
  const ModelPage({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${items.title}',
          style: const TextStyle(
              fontFamily: 'PoppinsBold',
              letterSpacing: 2.0,
              color: Colors.white,
              fontSize: 20.0),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: const Color(0xffcc021d),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [Colors.black, Colors.red, Colors.black])),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 230,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('${items.image}'),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high)),
              ),
            ]),
      ),
    );
  }
}
