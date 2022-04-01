import 'package:bcons_app/model/user_model.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/HistoryOfReports/data_history_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class HistoryOfReports extends StatefulWidget {
  const HistoryOfReports({Key? key}) : super(key: key);

  @override
  State<HistoryOfReports> createState() => _HistoryOfReportsState();
}

class _HistoryOfReportsState extends State<HistoryOfReports> {
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
          /*actions: [
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
          ],*/
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FirebaseAnimatedList(
            query: databaseReference,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map map = snapshot.value as Map;
              print(map.keys);

              List<DataHistoryModel> _dataHistoryModel = [
                DataHistoryModel(
                    emergencyTypeOfReport: map['emergencyTypeOfReport'],
                    imageUrl: map['image'],
                    description: map['description'],
                    date: map['date'],
                    time: map['time'],
                    longitude: map['longitude'],
                    latitude: map['latitude'],
                    address: map['address'])
              ];
              List<String> imageLength = [];
              imageLength.add(map['imageUrl'].toString());
              return cardUI(
                  map['image'].toString(),
                  map['emergencyTypeOfReport'].toString(),
                  map['description'].toString(),
                  map['latitude'].toString(),
                  map['longitude'].toString(),
                  map['address'].toString(),
                  map['date'].toString(),
                  map['time'].toString(),
                  context,
                  index,
                  _dataHistoryModel);
            },
          ),
        ));
  }
}

Widget cardUI(
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
    map) {
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
