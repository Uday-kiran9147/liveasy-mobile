import 'package:flutter/material.dart';

class Apptheme {
  static Color continuesButtonColor = Color.fromARGB(255, 57, 63, 114);
  static Color nextButtonColor = Color.fromARGB(46, 59, 98, 1);
  static Color otpFieldStyle = Color(0xff93D2F3);
  static TextStyle boldtitle =
      TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
}

Image curveImage(BuildContext context, String path) {
  return Image.asset(path,
      fit: BoxFit.fill, width: MediaQuery.of(context).size.width);
}

class Utils {
  static var buttomShape = MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)));
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static void navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static void navigateToReplacement(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
  }

  static void navigateToAndRemoveUntil(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);
  }
}
