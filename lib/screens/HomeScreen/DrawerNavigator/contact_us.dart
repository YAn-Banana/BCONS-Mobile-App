import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formkey = GlobalKey<FormState>();
  final nameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final detailsEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Us',
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
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Form(
                key: _formkey,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                  width: double.infinity,
                  height: 583,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Need help? Feel free to contact us any time. We will respond as soon as possible!',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                            letterSpacing: 2.0,
                            fontFamily: 'PoppinsRegular'),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'Name',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                            fontFamily: 'PoppinsBold'),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextForm('Your Name', nameEditingController,
                          MediaQuery.of(context).size.width, 50.0, 1),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'Email',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                            fontFamily: 'PoppinsBold'),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextForm('Your Email', emailEditingController,
                          MediaQuery.of(context).size.width, 50.0, 1),
                      const SizedBox(
                        height: 50.0,
                      ),
                      Text(
                        'Please enter the details',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                            fontFamily: 'PoppinsBold'),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextForm('', detailsEditingController,
                          MediaQuery.of(context).size.width, 109.0, 5),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              fixedSize: const Size(100.0, 10.0),
                              primary: const Color(0xffcc021d),
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1.0,
                                  fontSize: 13.0,
                                  fontFamily: 'PoppinsBold'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                color: const Color(0xffd90824),
                height: 100.0,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Contact  Info:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            letterSpacing: 1.5,
                            fontFamily: 'PoppinsRegular'),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.email,
                            size: 20.0,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'bcons2122@gmail.com',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                letterSpacing: 1.5,
                                fontFamily: 'PoppinsBold'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.phone,
                            size: 20.0,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '09311893178',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                letterSpacing: 1.5,
                                fontFamily: 'PoppinsBold'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget TextForm(
    String labelText,
    TextEditingController controller,
    double width,
    double height,
    int maxLines,
  ) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        onSaved: (value) {
          controller.text = value!;
        },
        maxLines: maxLines,
        autofocus: false,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          fillColor: Colors.white,
          filled: true,
          labelText: labelText,
          labelStyle: TextStyle(
              fontSize: 12.0,
              color: Colors.grey[400],
              fontFamily: 'PoppinsRegular',
              letterSpacing: 1.5),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 2.0, color: Color(0xffd90824)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 1.0, color: Color(0xffd90824)),
          ),
        ),
      ),
    );
  }
}
