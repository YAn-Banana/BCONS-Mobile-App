import 'package:bcons_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: IntroductionScreen(
            pages: [
              PageViewModel(
                title: 'Sign In Screen',
                body:
                    'The sign in page features different options to access the application. The user can sign using either an email address or mobile phone number. A user can create an account by tapping the sign up button.',
                image: buildImage('assets/images/SignIn.jpg'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                  title: 'Sign Up Screen',
                  body:
                      'If you choose to create an account using your email make sure that you enter a valid e-mail address. This address will be your means of recovery in case you forget your password. On the other hand, if you will use a phone number to sign up, see to it that you have access to that number.',
                  image: buildImage('assets/images/SignUp.jpg'),
                  decoration: getPageDecoration()),
              PageViewModel(
                title: 'Home Screen',
                body:
                    'After signing in, you will be directed to the home screen. You can see the bottom navigation bar which holds the following buttons; Home, Profile, Contacts, and Library. The bell icon allows you to view reports from nearby users. The drawer navigation button allows you to view other features of the application.',
                image: buildImage('assets/images/home(1).jpg'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'User Profile Screen',
                body:
                    'The User Profile Screen allows users to view and update the details that they provided in the Sign up page. Enabling the visibility will allow other users to contact you using the Nearby Users button in the Search List. It will also allow you to receive incoming reports from nearby users.',
                image: buildImage('assets/images/profile.jpg'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Contacts Screen',
                body:
                    'The Contacts Screen contains a list of contact information of Emergency Response Teams and local authorities. Tapping any of these phone icons will open the device\'s phone and dial the selected number instantly',
                image: buildImage('assets/images/contacts.jpg'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Library Screen',
                body:
                    'The Library contains information on emergency preparedness including the to do\'s before, during, and after emergencies and disasters. It also contains facts and tips regarding health care, crime, and hazards.',
                image: buildImage('assets/images/library.jpg'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Report Style Screen',
                body:
                    'After you tap the Report button, you will see the Report Style Screen. This Screen allows you to report either manually or using automation. Manual reports will require you to fill up details regarding your emergency. Reporting using automations will require you to upload a single photo and the application will classify the type of emergency you want to report.',
                image: buildImage('assets/images/ReportStyle.jpg'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'User Location Screen',
                body:
                    'After you tap the Get Location button, the application will display your coordinates and approximate location. This also allows the application to receive your current location details.',
                image: buildImage('assets/images/UserLocation.jpg'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Report Screen',
                body:
                    'This is where you upload a photo of your emergency. You can use your camera to take a photo or upload a media from your device\'s storage. The application will label the photo according to its classification. Refrain from using inappropriate photos or it might result in your account getting banned permanently.',
                image: buildImage('assets/images/report.jpg'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Confirmation Page',
                body:
                    'After selecting a photo, confirm if the type of emergency is accurate. Otherwise, retry taking or uploading another photo. You can opt to notify nearby users by tapping the "Send to nearby Users" checkbox. Confirm your report and wait for ERTs to respond. The application will then proceed to the Home Screen.',
                image: buildImage('assets/images/confirmation.jpg'),
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                title: 'Drawer Navigator Screen',
                body:
                    'This screen shows your profile information including your picture, name and contact information. You can also access the Messages button which leads you to the Chat Rooms. The History button will show you the list of all your reports after your account creation. The Contact Us button allows you to communicate with the developers for suggestions and recommendations. Lastly, the About BCONS shows details about the developers including their picture, name, and occupation.',
                image: buildImage('assets/images/DrawerNav.jpg'),
                decoration: getPageDecoration(),
              ),
            ],
            done: const Text('Done',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  letterSpacing: 1.5,
                  fontFamily: 'PoppinsBold',
                )),
            onDone: () => goHome(context),
            skip: const Text(
              'Skip',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  letterSpacing: 1.5,
                  fontFamily: 'PoppinsBold'),
            ),
            next: const Icon(Icons.arrow_forward, color: Colors.black),
            showSkipButton: true,
            showDoneButton: true,
            showNextButton: true,
            dotsDecorator: getDotsDecorator(),
            nextFlex: 0,
          ),
        ),
      ),
    );
  }

  Widget buildImage(String path) => Center(
          child: Image.asset(
        path,
        width: 400,
        height: 400,
        filterQuality: FilterQuality.high,
      ));

  PageDecoration getPageDecoration() => PageDecoration(
      titleTextStyle: const TextStyle(
          fontSize: 20.0, fontFamily: 'PoppinsBold', letterSpacing: 2.0),
      bodyTextStyle: const TextStyle(
          fontSize: 15.0, letterSpacing: 1.5, fontFamily: 'PoppinsRegular'),
      footerPadding: const EdgeInsets.all(5.0).copyWith(bottom: 0),
      imagePadding: const EdgeInsets.only(top: 20),
      pageColor: Colors.white);

  DotsDecorator getDotsDecorator() {
    return const DotsDecorator(
        activeColor: Colors.red,
        size: Size.square(1),
        activeSize: Size.square(5.0));
  }
}

void goHome(context) => Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => const LoginScreen()));
