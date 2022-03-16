import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/Emergency%20Libraries/emergency_details.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/Emergency%20Libraries/libraries_model.dart';
import 'package:flutter/material.dart';

class Covid19Tips extends StatefulWidget {
  const Covid19Tips({Key? key}) : super(key: key);

  @override
  State<Covid19Tips> createState() => _Covid19TipsState();
}

class _Covid19TipsState extends State<Covid19Tips> {
  static List<String> titleList = [
    'Covid(1)',
    'Covid(2)',
    'Covid(3)',
    'Covid(4)',
    'Covid(5)',
    'Covid(6)',
  ];
  static List<String> imageList = [
    'assets/images/Covid(1).png',
    'assets/images/Covid(2).png',
    'assets/images/Covid(3).png',
    'assets/images/Covid(4).png',
    'assets/images/Covid(5).png',
    'assets/images/Covid(6).png'
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
          'Covid19 Tips',
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