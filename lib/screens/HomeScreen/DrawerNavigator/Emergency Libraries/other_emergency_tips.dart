import 'package:flutter/material.dart';

import 'emergency_details.dart';
import 'libraries_model.dart';

class OtherEmergencyTips extends StatefulWidget {
  const OtherEmergencyTips({Key? key}) : super(key: key);

  @override
  State<OtherEmergencyTips> createState() => _OtherEmergencyTipsState();
}

class _OtherEmergencyTipsState extends State<OtherEmergencyTips> {
  static List<String> titleList = [
    'Drowning Incident',
    'Radiation Hazard',
    'Storm Preparedness',
    'Electrical Hazard',
    'Bombing Incident',
    'Chemical Hazard',
  ];
  static List<String> imageList = [
    'assets/images/Drowning.png',
    'assets/images/Radiation.png',
    'assets/images/storm.png',
    'assets/images/Electrical.png',
    'assets/images/Bombing.png',
    'assets/images/Chemical_Hazard.png',
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
          'Other Emergency Tips',
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
              colors: [Color.fromRGBO(0, 0, 0, 1), Colors.red, Colors.black]),
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
