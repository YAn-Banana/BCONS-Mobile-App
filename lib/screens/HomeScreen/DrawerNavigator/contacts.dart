import 'package:bcons_app/screens/HomeScreen/DrawerNavigator/Libraries/emergency_libraries.dart';
import 'package:bcons_app/screens/HomeScreen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'user_profile.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contacts',
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
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false)),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text(
                'General | Covid19',
                style: TextStyle(
                    fontFamily: 'PoppinsRegular',
                    letterSpacing: 1.5,
                    color: Color(0xffcc021d),
                    fontSize: 20.0),
              ),
              const SizedBox(
                height: 5,
              ),
              listTile('Bulakan Covid19 Hotline, Globe | TM', '+639661820059'),
              const SizedBox(
                height: 10,
              ),
              listTile('Bulakan Covid19 Hotline, Smart | Tnt', '+639310068118'),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Fire Accident',
                style: TextStyle(
                    fontFamily: 'PoppinsRegular',
                    letterSpacing: 1.5,
                    color: Color(0xffcc021d),
                    fontSize: 20.0),
              ),
              const SizedBox(
                height: 5,
              ),
              listTile('Beuaru of Fire Protection (BFP) Bulacan, Globe | TM',
                  '+639567456156'),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Natural Disater',
                style: TextStyle(
                    fontFamily: 'PoppinsRegular',
                    letterSpacing: 1.5,
                    color: Color(0xffcc021d),
                    fontSize: 20.0),
              ),
              const SizedBox(
                height: 5,
              ),
              listTile(
                  'Municipal Disaster Risk Reduction and Management Office (MDRRMO), Globe | TM',
                  '+639275777227'),
              const SizedBox(
                height: 10,
              ),
              listTile(
                  'Municipal Disaster Risk Reduction and Management Office (MDRRMO), Smart | Tnt',
                  '+639322312088'),
              const SizedBox(
                height: 10,
              ),
              listTile(
                  'Bulacan Provincial Disaster Risk Reduction and Management Council (PDRRMC)',
                  '7910556'),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Mental Health Awareness',
                style: TextStyle(
                    fontFamily: 'PoppinsRegular',
                    letterSpacing: 1.5,
                    color: Color(0xffcc021d),
                    fontSize: 20.0),
              ),
              const SizedBox(
                height: 5,
              ),
              listTile('Department of Health (DOH) Hotline, Globe | TM',
                  '+639178998727'),
              const SizedBox(
                height: 10,
              ),
              listTile('Department of Health (DOH) Hotline, Smart | Tnt',
                  '+639086392672'),
              const SizedBox(
                height: 10,
              ),
              listTileNoCall('Nationwide toll-free', '1800-1888-1553'),
              const SizedBox(
                height: 10,
              ),
              listTileNoCall('Luzon-wide landline toll-free', '1553'),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'General | Crime Awareness Hotline',
                style: TextStyle(
                    fontFamily: 'PoppinsRegular',
                    letterSpacing: 1.5,
                    color: Color(0xffcc021d),
                    fontSize: 20.0),
              ),
              const SizedBox(
                height: 5,
              ),
              listTile('Philippine National Police (PNP) Bulakan, Smart | Tnt',
                  '+639985985378'),
              const SizedBox(
                height: 10,
              ),
              listTileNoCall(
                  'Philippine National Police (PNP) Bulakan, Telephone no.',
                  '(044) 750-4812'),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Bulakan Bulacan Hospitals',
                style: TextStyle(
                    fontFamily: 'PoppinsRegular',
                    letterSpacing: 1.5,
                    color: Color(0xffcc021d),
                    fontSize: 20.0),
              ),
              const SizedBox(
                height: 5,
              ),
              listTileNoCall(
                  'Gen. Gregorio Hospital Telephone no.', '(044)792-0119'),
              const SizedBox(
                height: 10,
              ),
              listTileNoCall(
                  'Gen. Gregorio Hospital Telephone no.', '(044)792-0745'),
              const SizedBox(
                height: 10,
              ),
              listTile('Municipal Health Office Rural Health Unit, Globe | TM',
                  '+639661820059'),
              const SizedBox(
                height: 10,
              ),
              listTile('Municipal Health Office Rural Health Unit, Smart | Tnt',
                  '+639310068118'),
              const SizedBox(
                height: 15,
              ),
              listTile('National Hotline in the Philippines', '911'),
            ],
          )),
      persistentFooterButtons: [
        SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: const Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    subtitle: const Text(
                      'Home',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          letterSpacing: 1.5,
                          fontFamily: 'PoppinsRegular'),
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                          (route) => false);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: const Icon(Icons.person, color: Colors.black),
                    subtitle: const Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          letterSpacing: 1.5,
                          fontFamily: 'PoppinsRegular'),
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserProfile()),
                          (route) => false);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: const Icon(
                      Icons.phone,
                      color: Color(0xffd90824),
                    ),
                    subtitle: const Text(
                      'Contacts',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xffd90824),
                          fontSize: 9.0,
                          letterSpacing: 1.5,
                          fontFamily: 'PoppinsRegular'),
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactScreen()),
                          (route) => false);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: const Icon(Icons.book_outlined),
                    subtitle: const Text(
                      'Library',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          letterSpacing: 1.5,
                          fontFamily: 'PoppinsRegular'),
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Libraries()),
                          (route) => false);
                    },
                  ),
                ),
              ],
            ))
      ],
    );
  }

  Widget listTile(String name, String number) {
    return ListTile(
      title: Text(
        name,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 17.0,
            letterSpacing: 1.5,
            fontFamily: 'PoppinsRegular'),
      ),
      subtitle: Text(
        number,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            letterSpacing: 1.5,
            fontFamily: 'PoppinsRegular'),
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.phone,
          size: 30,
          color: Colors.black,
        ),
        onPressed: () async {
          await FlutterPhoneDirectCaller.callNumber(number);
        },
      ),
    );
  }

  Widget listTileNoCall(String name, String number) {
    return ListTile(
      title: Text(
        name,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 17.0,
            letterSpacing: 1.5,
            fontFamily: 'PoppinsRegular'),
      ),
      subtitle: Text(
        number,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            letterSpacing: 1.5,
            fontFamily: 'PoppinsRegular'),
      ),
    );
  }
}
