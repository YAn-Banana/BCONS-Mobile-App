import 'package:bcons_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../screens/HomeScreen/home_screen.dart';
import 'TypeOfReport/manual_report_with_confirmation.dart';

class UsersCurrentLocation extends StatefulWidget {
  const UsersCurrentLocation({Key? key}) : super(key: key);

  @override
  State<UsersCurrentLocation> createState() => _UsersCurrentLocationState();
}

class _UsersCurrentLocationState extends State<UsersCurrentLocation> {
  String location = '';
  String latitude = '';
  String longitude = '';
  String locality = '';
  String liveMunicipality = '';
  String province = '';
  bool isLoading = false;
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
      setState(() {});
    });
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
    locality = '${place.street} ${place.locality}';
    province = '${place.subAdministrativeArea},${place.country}';
    liveMunicipality = '${place.locality}';
    setState(() {});
    print(placemark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User\'s Current Location',
          style: TextStyle(
              fontFamily: 'PoppinsBold',
              letterSpacing: 2.0,
              color: Colors.white,
              fontSize: 20.0),
        ),
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: const Color(0xffcc021d),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                Position position = await _determinePosition();
                print(position);
                location =
                    'Latitude: ${position.latitude}, Longitude: ${position.longitude}';

                latitude = '${position.latitude}';
                longitude = '${position.longitude}';
                getAddressFromUserLongAndLat(position);
                setState(() {
                  isLoading = true;
                });
              },
              child: const Text('Get Location')),
          const SizedBox(
            height: 10,
          ),
          (isLoading == true)
              ? (latitude.isNotEmpty &&
                      longitude.isNotEmpty &&
                      locality.isNotEmpty &&
                      province.isNotEmpty)
                  ? Column(
                      children: [
                        const Text(
                          'Coordinate Points',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'PoppinsBold',
                              letterSpacing: 1.5,
                              color: Colors.black,
                              fontSize: 15.0),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$latitude, $longitude',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'PoppinsRegular',
                              letterSpacing: 1.5,
                              color: Colors.black,
                              fontSize: 15.0),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Address',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'PoppinsBold',
                              letterSpacing: 1.5,
                              color: Colors.black,
                              fontSize: 15.0),
                        ),
                        Text(
                          locality,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'PoppinsRegular',
                              letterSpacing: 1.5,
                              color: Colors.black,
                              fontSize: 15.0),
                        ),
                        Text(
                          province,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'PoppinsRegular',
                              letterSpacing: 1.5,
                              color: Colors.black,
                              fontSize: 15.0),
                        ),
                      ],
                    )
                  : const CircularProgressIndicator(
                      color: Color(0xffcc021d),
                    )
              : Container(),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: isLoading == true
                  ? () {
                      FirebaseFirestore firebaseFirestore =
                          FirebaseFirestore.instance;
                      firebase_auth.User? user = firebaseAuth.currentUser;
                      try {
                        firebaseFirestore
                            .collection('Users')
                            .doc(user!.uid)
                            .update({
                          'latitude': latitude,
                          'longitude': longitude,
                          'address': '$locality, $province',
                          'liveMunicipality': liveMunicipality
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreatePDF()));
                      } catch (e) {
                        final snackBar = SnackBar(content: Text(e.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  : () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                primary:
                    isLoading == true ? const Color(0xffcc021d) : Colors.grey,
              ),
              child: const Text('Continue')),
        ],
      )),
    );
  }
}
