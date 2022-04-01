import 'package:bcons_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  DateTime initialDate = DateTime.now();
  Stream<QuerySnapshot>? reportStream;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      onSearchMunicipalityButtonClick();
      setState(() {});
    });
  }

  Future<Stream<QuerySnapshot>> getTheFollowingReports(
    String municipality,
    String uid,
  ) async {
    return FirebaseFirestore.instance
        .collection('User Reports')
        .where('uid', isNotEqualTo: uid)
        .where('sendToNearbyUsers', isEqualTo: true)
        .where('status', isEqualTo: 'unsolved')
        .where('municipalityReport', isEqualTo: municipality)
        .snapshots();
  }

  onSearchMunicipalityButtonClick() async {
    reportStream = await getTheFollowingReports(
        '${loggedInUser.municipality}', '${loggedInUser.uid}');
    setState(() {});
  }

  Widget searchReportList() {
    return StreamBuilder(
        stream: reportStream,
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
          return snapshots.hasData
              ? ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshots.data!.docs[index];
                    return cardUI(
                        ds['name'],
                        ds['image'],
                        ds['emergencyTypeOfReport'],
                        ds['description'],
                        ds['latitude'],
                        ds['longitude'],
                        ds['address'],
                        ds['date'],
                        ds['time'],
                        context,
                        index);
                  })
              : const Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Notifications',
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
        /*floatingActionButton: FloatingActionButton(
            onPressed: () {
              onSearchMunicipalityButtonClick();
              setState(() {});
            },
            child: const Icon(
              Icons.search,
              size: 30,
            )),*/
        body: searchReportList());
  }
}

Widget cardUI(
  String? name,
  String? imageUrl,
  String? emergencyClass,
  String? description,
  String? latitude,
  String? longitude,
  String? exactAddress,
  String? exactDate,
  String? exactTime,
  BuildContext context,
  int index,
) {
  return Card(
    margin: const EdgeInsets.all(20),
    color: Colors.grey[300],
    child: Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Name: ',
                  style: TextStyle(
                      fontFamily: 'PoppinsBold',
                      letterSpacing: 1.5,
                      color: Colors.black,
                      fontSize: 15.0),
                ),
                Text(
                  name!,
                  style: const TextStyle(
                      fontFamily: 'PoppinsRegular',
                      letterSpacing: 1.5,
                      color: Colors.black,
                      fontSize: 15),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                        image: NetworkImage(imageUrl!),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                emergencyClass!,
                style: const TextStyle(
                    fontFamily: 'PoppinsBold',
                    letterSpacing: 2.0,
                    color: Color(0xffcc021d),
                    fontSize: 25),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  'Date: ',
                  style: TextStyle(
                      fontFamily: 'PoppinsBold',
                      letterSpacing: 1.5,
                      color: Colors.black,
                      fontSize: 15.0),
                ),
                Text(
                  exactDate!,
                  style: const TextStyle(
                      fontFamily: 'PoppinsRegular',
                      letterSpacing: 1.5,
                      color: Colors.black,
                      fontSize: 15.0),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Time: ',
                  style: TextStyle(
                      fontFamily: 'PoppinsBold',
                      letterSpacing: 1.5,
                      color: Colors.black,
                      fontSize: 15.0),
                ),
                Text(
                  exactTime!,
                  style: const TextStyle(
                      fontFamily: 'PoppinsRegular',
                      letterSpacing: 1.5,
                      color: Colors.black,
                      fontSize: 15.0),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Description',
              style: TextStyle(
                  fontFamily: 'PoppinsBold',
                  letterSpacing: 1.5,
                  color: Colors.black,
                  fontSize: 15.0),
            ),
            description!.isNotEmpty
                ? Text(
                    description,
                    style: const TextStyle(
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5,
                        color: Colors.black,
                        fontSize: 15.0),
                  )
                : const Text(
                    'None',
                    style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5,
                        color: Colors.black,
                        fontSize: 15.0),
                  ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Location: ',
              style: TextStyle(
                  fontFamily: 'PoppinsBold',
                  letterSpacing: 1.5,
                  color: Colors.black,
                  fontSize: 15.0),
            ),
            Text(
              exactAddress!,
              style: const TextStyle(
                  fontFamily: 'PoppinsRegular',
                  letterSpacing: 1.5,
                  color: Colors.black,
                  fontSize: 15.0),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  'Longitude: ',
                  style: TextStyle(
                      fontFamily: 'PoppinsBold',
                      letterSpacing: 1.5,
                      color: Colors.black,
                      fontSize: 15.0),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  longitude!,
                  style: const TextStyle(
                      fontFamily: 'PoppinsRegular',
                      letterSpacing: 1.5,
                      color: Colors.black,
                      fontSize: 15.0),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Latitude: ',
                  style: TextStyle(
                      fontFamily: 'PoppinsBold',
                      letterSpacing: 1.5,
                      color: Colors.black,
                      fontSize: 15.0),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  latitude!,
                  style: const TextStyle(
                      fontFamily: 'PoppinsRegular',
                      letterSpacing: 1.5,
                      color: Colors.black,
                      fontSize: 15.0),
                ),
              ],
            ),
          ]),
    ),
  );
}
