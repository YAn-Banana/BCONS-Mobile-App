import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class UsersCurrentLocation extends StatefulWidget {
  const UsersCurrentLocation({Key? key}) : super(key: key);

  @override
  State<UsersCurrentLocation> createState() => _UsersCurrentLocationState();
}

class _UsersCurrentLocationState extends State<UsersCurrentLocation> {
  String location = '';
  String address = '';

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
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getAddressFromUserLongAndLat(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User\'S Current Location',
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
          const Text(
            'Coordinate Points',
            style: TextStyle(
                fontFamily: 'PoppinsBold',
                letterSpacing: 1.5,
                color: Colors.black,
                fontSize: 15.0),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                Position position = await _determinePosition();
                print(position);

                location =
                    'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
                getAddressFromUserLongAndLat(position);
                setState(() {});
              },
              child: const Text('Get Location')),
          const SizedBox(
            height: 10,
          ),
          Text(
            location,
            style: const TextStyle(
                fontFamily: 'PoppinsRegular',
                letterSpacing: 1.5,
                color: Colors.black,
                fontSize: 15.0),
          )
        ],
      )),
    );
  }
}
