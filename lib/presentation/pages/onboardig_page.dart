import 'package:flutter/material.dart';

import 'package:liveasy/core/theme.dart';
import 'package:liveasy/presentation/pages/phone_no_page.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<String> _dropitem = ['English', 'Arabic', 'Hindi', 'Urdu'];

  String language = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Container(
              height: 40, width: 40, child: Image.asset("assets/Vectorp1.png")),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "Please select your language",
              style: Apptheme.boldtitle,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child:
                  Text("You can change the language \n            at anytime")),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(
              child: DropdownButton(
                value: language,
                items: _dropitem.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem(child: Text(e), value: e);
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    language = value!;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  shape: Utils.buttomShape,
                  fixedSize: MaterialStateProperty.all(Size(250, 50)),
                  backgroundColor:
                      MaterialStateProperty.all(Apptheme.continuesButtonColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                Utils.navigateTo(context, PhoneScreen());
              },
              child: Text("Next")),
          Spacer(),
          Stack(
            children: [
              curveImage(context, "assets/Vectorc2.png"),
              Positioned(
                  bottom: 0, child: curveImage(context, "assets/Vectorc1.png")),
            ],
          )
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.blue[800]!;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
