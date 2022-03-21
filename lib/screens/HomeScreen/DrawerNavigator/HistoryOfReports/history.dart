import 'package:bcons_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'data_history.dart';

class HistoryOfReports extends StatefulWidget {
  const HistoryOfReports({Key? key}) : super(key: key);

  @override
  State<HistoryOfReports> createState() => _HistoryOfReportsState();
}

class _HistoryOfReportsState extends State<HistoryOfReports> {
  List<Data> dataList = [];
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  bool searchState = false;
  bool search = false;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child('User\'s Report')
        .child(user!.uid);
    return Scaffold(
        appBar: AppBar(
          title: !searchState
              ? const Text(
                  'History of Reports',
                  style: TextStyle(
                      fontFamily: 'PoppinsBold',
                      letterSpacing: 2.0,
                      color: Colors.white,
                      fontSize: 20.0),
                )
              : TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30,
                    ),
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  ),
                  onChanged: (text) {},
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
          actions: [
            !searchState
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        searchState = !searchState;
                      });
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30,
                    ))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        searchState = !searchState;
                      });
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.white,
                      size: 30,
                    ))
          ],
        ),
        body: SingleChildScrollView(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FirebaseAnimatedList(
            query: databaseReference,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map map = snapshot.value as Map;
              return cardUI(
                  map['image'].toString(),
                  map['emergencyTypeOfReport'].toString(),
                  map['description'].toString(),
                  map['location'].toString(),
                  map['address'].toString(),
                  map['dateAndTime'].toString());
            },
          ),
        )));
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
                  fontFamily: 'PoppinsRegular',
                  letterSpacing: 2.0,
                  color: Colors.black,
                  fontSize: 10.0),
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              description!,
              style: const TextStyle(
                  fontFamily: 'PoppinsRegular',
                  letterSpacing: 2.0,
                  color: Colors.black,
                  fontSize: 10.0),
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              locationInMaps!,
              style: const TextStyle(
                  fontFamily: 'PoppinsRegular',
                  letterSpacing: 2.0,
                  color: Colors.black,
                  fontSize: 10.0),
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              exactAddress!,
              style: const TextStyle(
                  fontFamily: 'PoppinsRegular',
                  letterSpacing: 2.0,
                  color: Colors.black,
                  fontSize: 10.0),
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              exactDateAndTime!,
              style: const TextStyle(
                  fontFamily: 'PoppinsRegular',
                  letterSpacing: 2.0,
                  color: Colors.black,
                  fontSize: 10.0),
            ),
          ]),
    ),
  );
}
