import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:telephony/telephony.dart';

import 'package:liveasy/core/theme.dart';
import 'package:liveasy/presentation/pages/profile_page.dart';

class VerificationScreen extends StatefulWidget {
  static String verificationID = '';
  final String phno;

  const VerificationScreen({
    Key? key,
    required this.phno,
  }) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> with TickerProviderStateMixin {

  FirebaseAuth _auth = FirebaseAuth.instance;
  OtpFieldController _verificationCodeController = OtpFieldController();
  final Telephony telephony = Telephony.instance;

  String otp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Verify Phone",
                style: Apptheme.boldtitle,
              ),
              SizedBox(height: 20),
              Text("Code sent to ${widget.phno}"),
              SizedBox(height: 20),
              OTPTextField(
                outlineBorderRadius: 0,
                controller: _verificationCodeController,
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 50,
                style: TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,otpFieldStyle:OtpFieldStyle(
                  backgroundColor:Apptheme.otpFieldStyle,),
                onCompleted: (pin) {
                  otp = pin;
                },
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Utils.showSnackBar(context, 'Resend still in development.');
                },
                child: Text("Didn't receive the code? Request Again"),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  _signInWithPhoneNumber(context);
                },
                style: ButtonStyle(
                  shape: Utils.buttomShape,
                  fixedSize: MaterialStateProperty.all(Size(280, 50)),
                  backgroundColor:
                      MaterialStateProperty.all(Apptheme.continuesButtonColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: Text('Verify and Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        debugPrint(message.address);
        debugPrint(message.body);

        String sms = message.body.toString();

        if (message.body!.contains('quizmaker2-565b6.firebaseapp.com')) {
          String otpcode = sms.replaceAll(new RegExp(r'[^0-9]'), '');
          _verificationCodeController.set(otpcode.split(""));

          setState(() {
            // refresh state
          });
        } else {
          debugPrint("error");
        }
      },
      listenInBackground: false,
    );
  }

    Future<void> _signInWithPhoneNumber(BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: VerificationScreen.verificationID,
        smsCode: otp,
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      debugPrint('Successfully signed in UID: ${userCredential.user!.uid}');
      Utils.navigateTo(context, Profile());
    } catch (e) {
      debugPrint('Sign-in failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Sign-in failed. Please try again.$e'),
      ));
    }
  }
}
