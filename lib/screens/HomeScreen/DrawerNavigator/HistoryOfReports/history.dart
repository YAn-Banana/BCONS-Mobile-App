import 'package:bcons_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'data_history.dart';

class HistoryOfReports extends StatefulWidget {
  const HistoryOfReports({Key? key}) : super(key: key);

  @override
  State<HistoryOfReports> createState() => _HistoryOfReportsState();
}

class _HistoryOfReportsState extends State<HistoryOfReports> {
  List<Data> dataList = [];

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    UserModel loggedInUser = UserModel();
    super.initState();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('User\'s Report');

    databaseReference.once().then((dataSnapshot) {
      print('${loggedInUser.uid}');
      print(dataSnapshot.snapshot.value);
      dataList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History of Reports',
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
      body: dataList.isEmpty
          ? const Center(
              child: Text(
                'No data available',
                style: TextStyle(
                    fontFamily: 'PoppinsBold',
                    letterSpacing: 2.0,
                    color: Colors.black,
                    fontSize: 20.0),
              ),
            )
          : SingleChildScrollView(
              child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return cardUI(
                      dataList[index].image,
                      dataList[index].emergencyTypeOfReport,
                      dataList[index].description,
                      dataList[index].location,
                      dataList[index].address,
                      dataList[index].dateAndTime,
                    );
                  }),
            )),
    );
  }
}

Widget cardUI(String? imageUrl, String? emergencyClass, String? description,
    String? locationInMaps, String? exactAddress, String? exactDateAndTime) {
  return Card(
    margin: const EdgeInsets.all(15),
    color: Colors.white,
    child: Container(
      color: Colors.white,
      margin: const EdgeInsets.all(1.5),
      padding: const EdgeInsets.all(10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              height: 100,
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              emergencyClass!,
              style: const TextStyle(
                  fontFamily: 'PoppinsBold',
                  letterSpacing: 2.0,
                  color: Colors.black,
                  fontSize: 20.0),
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              description!,
              style: const TextStyle(
                  fontFamily: 'PoppinsBold',
                  letterSpacing: 2.0,
                  color: Colors.black,
                  fontSize: 20.0),
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              locationInMaps!,
              style: const TextStyle(
                  fontFamily: 'PoppinsBold',
                  letterSpacing: 2.0,
                  color: Colors.black,
                  fontSize: 20.0),
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              exactAddress!,
              style: const TextStyle(
                  fontFamily: 'PoppinsBold',
                  letterSpacing: 2.0,
                  color: Colors.black,
                  fontSize: 20.0),
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              exactDateAndTime!,
              style: const TextStyle(
                  fontFamily: 'PoppinsBold',
                  letterSpacing: 2.0,
                  color: Colors.black,
                  fontSize: 20.0),
            ),
          ]),
    ),
  );
}
