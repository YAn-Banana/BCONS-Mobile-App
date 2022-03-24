import 'package:bcons_app/PracticeFunctions/getUserCurrentLocation.dart';
import 'package:flutter/material.dart';

class ChooseReport extends StatefulWidget {
  const ChooseReport({Key? key}) : super(key: key);

  @override
  _ChooseReportState createState() => _ChooseReportState();
}

void chooseManualReport(BuildContext context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const UsersCurrentLocation()));
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
            Container(
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
                      chooseManualReport(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150.0,
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
                            'Lorem Ipsum',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                              letterSpacing: 2.0,
                              fontFamily: 'PoppinsBold',
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(40, 25.0, 40.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150.0,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: const Color(0xffd90824),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            'AUTOMATED',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2.0,
                              fontFamily: 'PoppinsBold',
                            ),
                          ),
                          Text(
                            'REPORT',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2.0,
                              fontFamily: 'PoppinsBold',
                            ),
                          ),
                          Text(
                            'Lorem Ipsum',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
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
          ],
        ));
  }
}
