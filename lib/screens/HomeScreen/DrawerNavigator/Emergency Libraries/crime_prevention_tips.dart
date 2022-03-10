import 'package:flutter/material.dart';

import 'emergency_details.dart';
import 'libraries_model.dart';

class CrimePreventionTips extends StatefulWidget {
  const CrimePreventionTips({Key? key}) : super(key: key);

  @override
  State<CrimePreventionTips> createState() => _CrimePreventionTipsState();
}

class _CrimePreventionTipsState extends State<CrimePreventionTips> {
  static List<String> titleList = [
    'Crime Robbery(1)',
    'Crime Robbery(2)',
    'Crime Theft(1)',
    'Crime Theft(2)',
  ];
  static List<String> imageList = [
    'assets/images/CrimeRobbery(1).png',
    'assets/images/CrimeRobbery(2).png',
    'assets/images/CrimeTheft(1).png',
    'assets/images/CrimeTheft(2).png',
  ];
  final List<EmergencyTipsDataModel> emergencyDataModel = List.generate(
      imageList.length,
      (index) => EmergencyTipsDataModel(
          title: titleList[index], imageUrl: imageList[index]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crime Prevention Tips',
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [Colors.black, Colors.red, Colors.black]),
        ),
        child: ListView.builder(
            itemCount: emergencyDataModel.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 0,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(5),
                  leading: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(emergencyDataModel[index].imageUrl),
                  ),
                  title: Text(
                    emergencyDataModel[index].title,
                    style: const TextStyle(
                        fontFamily: 'PoppinsBold',
                        letterSpacing: 1.5,
                        color: Colors.black,
                        fontSize: 20.0),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => EmergencyDetails(
                            dataModel: emergencyDataModel[index]))));
                  },
                ),
              );
            }),
      ),
    );
  }
}
