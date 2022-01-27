import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Privacy Policy',
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
<<<<<<< HEAD
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
=======
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 80.0),
                  child: ListView(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Privacy Policy',
                            style: TextStyle(
                                color: Color(0xffd90824),
                                fontSize: 30.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const Text(
                            'Bulacan Collaborative Network for Safety (BCONS), we are committed to protecting your privacy. This Privacy Policy explains how your personal information is collected, used, and disclosed by Bulacan Collaborative Network for Safety (BCONS). This Privacy Policy applies to our application named Bulacan Collaborative Network for Safety (BCONS), and its associated subdomains. By accessing or using our Service, you signify that you have reviewed, understood, and agree with our collection, storage, use, and disclosure of your personal information as described in this Privacy Policy and our Terms of Service.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text('Definitions and Key Terms',
                            style: TextStyle(
                                color: Color(0xffd90824),
                                fontSize: 30.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const Text('For this Privacy Policy: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text('Local Area',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                            'Where Bulacan Collaborative Network for Safety (BCONS) or the owners/founders of Bulacan Collaborative Network for Safety (BCONS) are based, in this case is Bulakan, Bulacan.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text('Device',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                            'Any mobile device connected to the internet can be used to visit Bulacan Collaborative Network for Safety (BCONS) and use the services.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text('Local Government Unit',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                            'Refers to the workers who are directly involved in the sector of health, law enforcement, and local barangay units that can be contacted in case of emergencies.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text('Personnel',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                            'Refers to those individuals who are involved in the development of Bulacan Collaborative Network for Safety (BCONS) or are under the obligation to perform service.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text('Personal Data',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                            'Any information that directly, or indirectly, or in connection with other information - including a personal identification number - allows for the identification or identifiability of a person.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text('Service',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                            'Refers to the service provided by Bulacan Collaborative Network for Safety (BCONS) as described in the relative terms on this platform.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text('You',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                            'A person or entity that is registered with Bulacan Collaborative Network for Safety (BCONS) to use the Services.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text('What Information Do We Collect?',
                            style: TextStyle(
                                color: Color(0xffd90824),
                                fontSize: 30.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const Text(
                            'We collect information from you when you visit our service, and register are the following: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text('Name',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text('Phone Number',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text('Email Address',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text('Age',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text('Password',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text('Birthday',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text('Address',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text('Current Location',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text('How Do We Use The Information We Collect?',
                            style: TextStyle(
                                color: Color(0xffd90824),
                                fontSize: 30.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const Text(
                            'Any of the following we collect from you may be used in one of the following ways:',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text(
                            'To use our service (to prevent fraudulent crimes and to record information to be used by the local government units once an emergency arise)',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                            'Do we share the information we collect with third parties?',
                            style: TextStyle(
                                color: Color(0xffd90824),
                                fontSize: 30.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const Text(
                            'We may share the information we collect, both personal and non-personal, with third party service providers to perform functions and provide services to us, maintaining our servers and our service, database storage and management, location management, to be used through our platform. We will likely share your personal information, and possibly some non-personal information, with these third parties to enable them to perform these services for us and for you.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                            'We may also disclose personal and non-personal information about you to government or law enforcement authorities or officials of Bulacan State University as we, in our sole discretion, believe necessary or appropriate in order to respond to claims, legal process (including subpoenas), to protect our rights and interests or those of a third party, the safety of the public or any person, to prevent or stop, illegal, unethical, or to otherwise comply with applicable court orders, laws, rules and regulations',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text('Affiliates',
                            style: TextStyle(
                                color: Color(0xffd90824),
                                fontSize: 30.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const Text(
                            'We may disclose information (including personal information) about you to our Corporate Affiliates. For purposes of this Privacy Policy, “Corporate Affiliate” means any person or entity which directly or indirectly controls, is controlled by or is under common control with us, whether by ownership or otherwise. Any information relating to you that we provide to our Corporate Affiliates will be treated by those Corporate Affiliates in accordance with the terms of this Privacy Policy.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text('Data Privacy Act of 2021',
                            style: TextStyle(
                                color: Color(0xffd90824),
                                fontSize: 30.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const Text(
                            'In accordance with Republic Act No. 10173 or the Data Privacy Act of 2012, we, the developers of Bulacan Collaborative Network for Safety (BCONS) , adhere to this national law. The personal information we collect may be used to:',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text(
                            'Provide to the local government units that are intertwined with emergency services which are entitled to the information under existing.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text(
                            'Contact you which includes the sending of electronic information to you.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text('Kid\'s Privacy',
                            style: TextStyle(
                                color: Color(0xffd90824),
                                fontSize: 30.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const Text(
                            'We do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If you are a parent or a guardian and you are aware that your child has provided us with personal data, please contact us. If we become aware that we have collected personal data from anyone under the age of 13 without verification of parental consent, we take steps to remove that information from our servers.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text('Tracking Technologies',
                            style: TextStyle(
                                color: Color(0xffd90824),
                                fontSize: 30.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const Text('Google Maps APIs',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                            'Google Maps API is a robust tool that can be used to create a custom map, a searchable map, check-in functions, display live data synching with location, plan routes, or create a mashup just to name a few.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                            'Google Maps API may collect information from You and from Your Device for security purposes.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                            'Google Maps API collects information that is held in accordance with its Privacy Policy.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text('Local Storage',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsBold',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Text(
                            'Local Storage, sometimes known as DOM storage, provides web apps with methods and protocols for storing client-side data. Web storage supports persistent data storage, similar to  cookies but with a greatly enhanced capacity and no information stored in the HTTP request header.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text(
                            'This privacy statement discloses the privacy practices of www.inquirer.net. It is our continuing goal to build users\' trust and confidence in the Internet by promoting the use of fair information practices. Because we want to demonstrate our commitment to your privacy, we have agreed to disclose our information and user privacy practices.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontFamily: 'PoppinsRegular',
                                letterSpacing: 2.0)),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  fixedSize: const Size(100.0, 10.0),
                                  primary: const Color(0xffcc021d),
                                ),
                                child: const Text(
                                  'Done',
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 1.0,
                                      fontSize: 13.0,
                                      fontFamily: 'PoppinsBold'),
                                )),
                          ],
                        )
                      ],
                    )
                  ])),
            ),
          ),
        ));
>>>>>>> 8929527e4272b8d83c1cd1e73e7f8e75af3c11c4
  }
}
