import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms and Conditions',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 80.0),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('General Terms',
                          style: TextStyle(
                              color: Color(0xffd90824),
                              fontSize: 30.0,
                              fontFamily: 'PoppinsBold',
                              letterSpacing: 2.0)),
                      Text(
                          'By accessing and using the application , you confirm that you are in agreement with and bound by the terms of service contained in the Terms & Conditions outlined below. These terms apply to the entire website and any email or other type of communication between you and . Under no circumstances shall team be liable for any direct, indirect, special, incidental or consequential damages, including, but not limited to, loss of data or profit, arising out of the use, or the inability to use, the materials on this site, even if team or an authorized representative has been advised of the possibility of such damages. If your use of materials from this site results in the need for servicing, repair or correction of equipment or data, you assume any costs thereof. will not be responsible for any outcome that may occur during the course of usage of our resources. We reserve the rights to change prices and revise the resources usage policy in any moment.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsRegular',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text('License',
                          style: TextStyle(
                              color: Color(0xffd90824),
                              fontSize: 30.0,
                              fontFamily: 'PoppinsBold',
                              letterSpacing: 2.0)),
                      Text(
                          'Bulacan Collaborative Network for Safety(BCONS) grants you a revocable, non-exclusive, non- transferable, limited license to download, install and use our service strictly in accordance with the terms of this Agreement. These Terms & Conditions are a contract between you and Bulacan Collaborative Network for Safety(BCONS) (referred to in these Terms & Conditions as "Bulacan Collaborative Network for Safety(BCONS)", "us", "we" or "our"), the provider of the Bulacan Collaborative Network for Safety(BCONS) website and the services accessible from the Bulacan Collaborative Network for Safety(BCONS) website (which are collectively referred to in these Terms & Conditions as the "Bulacan Collaborative Network for Safety(BCONS) Service"). You are agreeing to be bound by these Terms & Conditions. If you do not agree to these Terms & Conditions, please do not use the Service. In these Terms & Conditions, "you" refers both to you as an individual and to the entity you represent. If you violate any of these Terms & Conditions, we reserve the right to cancel your account or block access to your account without notice.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsRegular',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text('Definitions and Key Terms',
                          style: TextStyle(
                              color: Color(0xffd90824),
                              fontSize: 30.0,
                              fontFamily: 'PoppinsBold',
                              letterSpacing: 2.0)),
                      Text('For this Terms & Conditions: ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsRegular',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('Cookie',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsBold',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                          'Small amount of data generated by a website and saved by your web browser. It is used to identify your browser, provide analytics, remember information about you such as your language preference or login information.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsRegular',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('Company',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsBold',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                          'When this policy mentions “Company,” “we,” “us,” or “our,” it refers to Bulacan Collaborative Network for Safety(BCONS) that is responsible for your information under this Privacy Policy.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsRegular',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('Country',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsBold',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                          'Where Bulacan Collaborative Network for Safety(BCONS) or the owners/founders of Bulacan Collaborative Network for Safety(BCONS) are based, in this case is Philippines.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsRegular',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('Customer',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsBold',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                          'Refers to the company, organization or person that signs up to use the Bulacan Collaborative Network for Safety(BCONS) Service to manage the relationships with your consumers or service users.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsRegular',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('Device',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsBold',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                          'Any internet connected device such as a phone, tablet, computer or any other device that can be used to visit Bulacan Collaborative Network for Safety(BCONS) and use the services.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsRegular',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('IP Address',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsBold',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                          'Every device connected to the Internet is assigned a number known as an Internet protocol (IP) address. These numbers are usually assigned in geographic blocks. An IP address can often be used to identify the location from which a device is connecting to the Internet.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsRegular',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('Personnel',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsBold',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                          'Refers to those individuals who are employed by Bulacan Collaborative Network for Safety(BCONS) or are under contract to perform a service on behalf of one of the parties.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsRegular',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('Personal Data',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsBold',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                          'Any information that directly, indirectly, or in connection with other information — including a personal identification number — allows for the identification or identifiability of a natural person.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsRegular',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('Service',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsBold',
                              letterSpacing: 2.0)),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                          'Refers to the service provided by Bulacan Collaborative Network for Safety(BCONS) as described in the relative terms (if available) and on this platform.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontFamily: 'PoppinsRegular',
                              letterSpacing: 2.0)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
