import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/core/theme.dart';

import 'package:liveasy/presentation/pages/otp_verification_page.dart';

class AuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    int? forceToken;

    // constructor
    AuthService(){
      debugPrint(forceToken.toString());
    }
  Future<void> signInWithMobile({required BuildContext context, required String mobileNumber}) async {

    debugPrint('Mobile number: $mobileNumber');
    await _firebaseAuth.verifyPhoneNumber(
      // receive in codeSent callback.
      forceResendingToken: forceToken,
      phoneNumber: mobileNumber,
      verificationCompleted: (PhoneAuthCredential credential) =>_verificationCompleted(credential, context),
      verificationFailed: (error) => _verificationFailed(error, context),
      codeSent: (verificationId, forceResendingToken) =>_codeSent(verificationId, forceResendingToken, context, mobileNumber),
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
    );
  }

  void _verificationCompleted(
      PhoneAuthCredential credential, BuildContext context) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      // Authentication successful, handle authenticated user.
      // For example, you can save user information, navigate to another screen, etc.
      debugPrint('auth class');
      debugPrint('User authenticated auth class: ${userCredential.user!.uid}');
    } catch (e) {
      debugPrint('Error during verification completion: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Sign-in failed. Please try again.'),
      ));
      // Handle error appropriately
    }
  }

  void _verificationFailed(FirebaseAuthException e, BuildContext context) {
    debugPrint('Phone verification failed: ${e.message}');
    // Handle verification failure appropriately, e.g., show an error message to the user
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Phone verification failed: ${e.message}'),
    ));
  }

  void _codeSent(String verificationId, int? forceResendingToken,BuildContext context, String mobileNumber) {
    forceToken = forceResendingToken;
    debugPrint('new forceToken: ' + forceToken!.toString());
    // Handle code sent scenario if needed
    VerificationScreen.verificationID = verificationId;

    Utils.navigateTo(context, VerificationScreen(phno:mobileNumber));
    debugPrint(
        'Verification code sent to number: ${VerificationScreen.verificationID}');
  }

  void _codeAutoRetrievalTimeout(String verificationId) {
    // Handle code auto-retrieval timeout scenario if needed
    VerificationScreen.verificationID = verificationId;
    debugPrint(
        'Verification code auto-retrieval timeout: ${VerificationScreen.verificationID}');
  }
}
