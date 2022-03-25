import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/Emergency%20Libraries/libraries_model.dart';
import 'package:flutter/material.dart';

class EmergencyDetails extends StatelessWidget {
  final EmergencyTipsDataModel dataModel;
  const EmergencyDetails({Key? key, required this.dataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          dataModel.title,
          style: const TextStyle(
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
      body: InteractiveViewer(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [Colors.black, Colors.red, Colors.black]),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                      image: AssetImage(dataModel.imageUrl),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }
}
