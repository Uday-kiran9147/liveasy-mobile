// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:liveasy/core/theme.dart';
import 'package:telephony/telephony.dart';
import '../pages/otp_verification_page.dart';

import '../../data/services/authentication.dart';

class PhoneScreen extends StatefulWidget {
  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  String? _selectedCountry = "+91";
  TextEditingController _controller = TextEditingController();
  AuthService _authService = AuthService();
  Telephony telephony = Telephony.instance;

  @override
  void initState() {
    super.initState();

    // Listen to incoming sms
    telephony.listenIncomingSms(
      onNewMessage: (message) {},
      listenInBackground: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Spacer(),
            SizedBox(
              height: 20,
            ),
            Text(
              'Please enter your mobile number',
              style: Apptheme.boldtitle,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
                'You\'ll receive a 6 digit code \n             to verify next.'),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5, color: Colors.black),
                ),
                child: Row(
                  children: [
                    DropdownButton<String?>(
                      dropdownColor: Colors.grey[200],
                      hint: Text("country"),
                      value: _selectedCountry,
                      onChanged: (String? newvalue) {
                        setState(() {
                          _selectedCountry = newvalue!;
                        });
                      },
                      items: <String>["+91", "+11", "+23", "+12"]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem(
                            alignment: Alignment.center,
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.black),
                            ));
                      }).toList(),
                    ),
                    Expanded(
                        child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 20),
                        border: InputBorder.none,
                        hintText: 'Mobile Number',
                      ),
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_controller.text.length != 10) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please enter a valid phone number"),
                      duration: Duration(seconds: 2),
                    ));
                    return;
                  }
                  // debugPrint(_selectedCountry! + _controller.text);
                  String mobile = _selectedCountry! + _controller.text.trim();
                  await _authService.signInWithMobile(
                      context: context, mobileNumber: mobile);
                  // Utils.navigateTo(
                  //     context, VerificationScreen(phno: '875458787348'));
                },
                style: ButtonStyle(
                    shape: Utils.buttomShape,
                    fixedSize: MaterialStateProperty.all(Size(280, 50)),
                    backgroundColor: MaterialStateProperty.all(
                        Apptheme.continuesButtonColor),
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
                child: Text('continue')),
            //Spacer(),
            Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight -
                  280,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: curveImage(context, "assets/Vectorc6.png"),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: curveImage(context, "assets/Vectorc5.png"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
