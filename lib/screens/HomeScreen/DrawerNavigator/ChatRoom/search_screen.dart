import 'package:bcons_app/model/user_model.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/ChatRoom/chat_mate.dart';
import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/ChatRoom/chat_room.dart';
import 'package:bcons_app/screens/HomeScreen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? loggedInUser = UserModel();
  TextEditingController searcheditingcontroller = TextEditingController();
  QuerySnapshot? searchSnapshot;
  Stream<QuerySnapshot?>? userStream;
  Stream<QuerySnapshot?>? municipalityStream;
  bool isSearching = false;
  String? liveMunicipality;
  bool isClickedSearchNearby = false;

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
    setState(() {});
  }

  Future<Stream<QuerySnapshot?>>? getUserByUserName(
      String userName, String uid) async {
    return FirebaseFirestore.instance
        .collection('Users')
        .where('uid', isNotEqualTo: uid)
        .where('firstName', isEqualTo: userName)
        .snapshots();
  }

  Future<Stream<QuerySnapshot?>>? getUserByTheirMunicipality(
      String municipality, String uid) async {
    return FirebaseFirestore.instance
        .collection('Users')
        .where('uid', isNotEqualTo: uid)
        .where('visibility', isEqualTo: 'Yes')
        .where(
          'municipality',
          isEqualTo: municipality,
        )
        .snapshots();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddressFromUserLongAndLat(Position position) async {
    List<Placemark> placemark = await GeocodingPlatform.instance
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];

    setState(() {
      //locality = '${place.street} ${place.locality}';
      //municipality = '${place.subAdministrativeArea},${place.country}';
      liveMunicipality = '${place.locality}';
    });
    print(placemark);
  }

  onSearchUserNameButtonClick() async {
    isSearching = true;
    userStream = await getUserByUserName(
        searcheditingcontroller.text, '${loggedInUser!.uid}');
    setState(() {});
  }

  onSearchMunicipalityButtonClick() async {
    isSearching = true;
    municipalityStream = await getUserByTheirMunicipality(
        '${loggedInUser!.liveMunicipality}', '${loggedInUser!.uid}');
    setState(() {});
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createChatRoom(
      String? chatRoomId, Map<String, dynamic>? chatRoomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();

    if (snapShot.exists) {
      // chatroom already exists
      return true;
    } else {
      // chatroom does not exists
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap!);
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget searhListUserTile(
      {String? imageUrl,
      String? lastName,
      String? firstName,
      String? midName,
      String? email,
      String? uid,
      String? status,
      String? liveLongitude,
      String? liveLatitude,
      int? distance}) {
    return GestureDetector(
      onTap: () {
        var chatRoomId = getChatRoomIdByUsernames('${loggedInUser!.uid}', uid!);
        Map<String, dynamic>? chatRoomInfoMap = {
          "users": ['${loggedInUser!.uid}', uid]
        };
        createChatRoom(chatRoomId, chatRoomInfoMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatMateRoom(
                      chatMateFirstName: firstName!,
                      chatMateLastName: lastName!,
                      chatMateUid: uid,
                      status: status!,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          status == 'online'
              ? CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.green[800],
                )
              : const CircleAvatar(
                  radius: 10,
                  backgroundColor: Color(0xffd90824),
                ),
          const SizedBox(
            width: 10,
          ),
          imageUrl != null
              ? Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(imageUrl), fit: BoxFit.cover)),
                )
              : Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/profile.png'),
                          fit: BoxFit.cover)),
                ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (midName!.isNotEmpty)
                Text(
                  '$firstName $midName. $lastName ',
                  style: const TextStyle(
                      fontFamily: 'PoppinsRegular',
                      letterSpacing: 1.5,
                      color: Colors.black,
                      fontSize: 12.0),
                )
              else
                Text(
                  '$firstName $lastName ',
                  style: const TextStyle(
                      fontFamily: 'PoppinsRegular',
                      letterSpacing: 1.5,
                      color: Colors.black,
                      fontSize: 12.0),
                ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xffcc021d),
                    size: 20,
                  ),
                  Text(
                    '$distance meter away',
                    style: const TextStyle(
                        fontFamily: 'PoppinsRegular',
                        letterSpacing: 1.5,
                        color: Colors.black,
                        fontSize: 12.0),
                  ),
                ],
              )
            ],
          )
        ]),
      ),
    );
  }

  Widget searchListByUserName() {
    return StreamBuilder(
        stream: userStream,
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot?>? snapshots) {
          return snapshots!.hasData
              ? ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshots.data!.docs[index];

                    return searhListUserTile(
                        imageUrl: ds['image'],
                        lastName: ds['lastName'],
                        firstName: ds['firstName'],
                        midName: ds['middleInitial'],
                        email: ds['email'],
                        uid: ds['uid'],
                        status: ds['status'],
                        liveLatitude: ds['liveLatitude'],
                        liveLongitude: ds['liveLongitude'],
                        distance: Geolocator.distanceBetween(
                                double.parse('${loggedInUser!.liveLatitude}'),
                                double.parse('${loggedInUser!.liveLongitude}'),
                                double.parse('${ds['liveLatitude']}'),
                                double.parse('${ds['liveLongitude']}'))
                            .round()
                            .toInt());
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Widget searchListByMunicipality() {
    return StreamBuilder(
        stream: municipalityStream,
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot?>? snapshots) {
          return snapshots!.hasData
              ? ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshots.data!.docs[index];
                    return searhListUserTile(
                        imageUrl: ds['image'],
                        lastName: ds['lastName'],
                        firstName: ds['firstName'],
                        midName: ds['middleInitial'],
                        email: ds['email'],
                        uid: ds['uid'],
                        status: ds['status'],
                        liveLatitude: ds['liveLatitude'],
                        liveLongitude: ds['liveLongitude'],
                        distance: Geolocator.distanceBetween(
                                double.parse('${loggedInUser!.liveLatitude}'),
                                double.parse('${loggedInUser!.liveLongitude}'),
                                double.parse('${ds['liveLatitude']}'),
                                double.parse('${ds['liveLongitude']}'))
                            .round()
                            .toInt());
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Widget chatRoomsList() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Screen',
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
      floatingActionButton: (isClickedSearchNearby == false)
          ? FloatingActionButton(
              backgroundColor: const Color(0xffcc021d),
              onPressed: (() async {
                Position position = await _determinePosition();
                getAddressFromUserLongAndLat(position);
                setState(() {
                  isClickedSearchNearby = true;
                  Fluttertoast.showToast(
                      msg:
                          'Your Location has been set to the latitude of ${position.latitude} and to the longitude of ${position.longitude}');
                });
              }),
              child: const Icon(Icons.place, size: 30, color: Colors.white))
          : FloatingActionButton(
              backgroundColor: const Color(0xffcc021d),
              onPressed: (() {
                FirebaseFirestore firebaseFirestore =
                    FirebaseFirestore.instance;
                firebase_auth.User? user = firebaseAuth.currentUser;
                try {
                  firebaseFirestore
                      .collection('Users')
                      .doc(user!.uid)
                      .update({'liveMunicipality': liveMunicipality});
                } catch (e) {
                  final snackBar = SnackBar(content: Text(e.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                onSearchMunicipalityButtonClick();
                setState(() {});
              }),
              child: const Text(
                'Nearby Users',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'PoppinsRegular',
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontSize: 10),
              )),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  Container(
                    color: const Color(0xffd90824),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: Row(children: [
                      Expanded(
                        child: TextField(
                            controller: searcheditingcontroller,
                            style: const TextStyle(color: Colors.white),
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                                hintText: 'Search Users by their first name...',
                                hintStyle: TextStyle(
                                    fontFamily: 'PoppinsRegular',
                                    letterSpacing: 1.5,
                                    color: Colors.white,
                                    fontSize: 12.0),
                                border: InputBorder.none)),
                      ),
                      InkWell(
                        onTap: () {
                          isClickedSearchNearby = false;
                          onSearchUserNameButtonClick();
                          setState(() {});
                        },
                        child: const SizedBox(
                            width: 40,
                            height: 40,
                            child: CircleAvatar(
                              backgroundColor: Color(0xffcc021d),
                              radius: 50,
                              child: Icon(
                                (Icons.search),
                                size: 30,
                                color: Colors.white,
                              ),
                            )),
                      )
                    ]),
                  ),
                  isSearching
                      ? isClickedSearchNearby
                          ? searchListByMunicipality()
                          : searchListByUserName()
                      : chatRoomsList()
                ],
              ),
            ],
          )),
    );
  }
}
