import 'package:bcons_app/PracticeFunctions/getUserCurrentLocationFromAuto.dart';
import 'package:bcons_app/PracticeFunctions/getUserCurrentLocationFromManual.dart';
import 'package:flutter/material.dart';

class ChooseReport extends StatefulWidget {
  const ChooseReport({Key? key}) : super(key: key);

  @override
  _ChooseReportState createState() => _ChooseReportState();
}

void getUserCurrentLocationManual(BuildContext context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const UsersCurrentLocation()));
}

void getUserCurrentLocationAuto(BuildContext context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const UserCurrentLocationAuto()));
}

class _ChooseReportState extends State<ChooseReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Choose Report Style',
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
            Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height / 2 - 80,
                width: double.infinity,
                color: const Color(0xffd90824),
                padding: const EdgeInsets.fromLTRB(40, 0.0, 40.0, 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Report Using: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        fontFamily: 'PoppinsBold',
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    InkWell(
                      onTap: () {
                        getUserCurrentLocationManual(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200.0,
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'MANUAL REPORT',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffd90824),
                                letterSpacing: 2.0,
                                fontFamily: 'PoppinsBold',
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'User will manually choose their emergency',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                                letterSpacing: 1.5,
                                fontFamily: 'PoppinsRegular',
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(40, 25.0, 40.0, 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        getUserCurrentLocationAuto(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200.0,
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: const Color(0xffd90824),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'AUTOMATED',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2.0,
                                fontFamily: 'PoppinsBold',
                              ),
                            ),
                            const Text(
                              'REPORT',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2.0,
                                fontFamily: 'PoppinsBold',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'User will provide a live image of the disaster from your current location',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[300],
                                letterSpacing: 2.0,
                                fontFamily: 'PoppinsRegular',
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
