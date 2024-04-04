import 'package:flutter/material.dart';

import '../../core/theme.dart';

enum SignIN { shipper, transporter }

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SignIN? _character = SignIN.shipper;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
      padding: const EdgeInsets.all(12.0),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Spacer(),
        SizedBox(
          height: 20,
        ),
        Text(
          'Please select your profile',
          style: Apptheme.boldtitle,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(border: Border.all(width: 1.5)),
          child: ListTile(
            style: ListTileStyle.list,
            title: Row(
              children: [
                Image.asset(
                  'assets/shipper.png',
                  height: 50,
                  width: 50,
                ),
                Text('   Shipper'),
              ],
            ),
            leading: Radio<SignIN>(
              value: SignIN.shipper,
              groupValue: _character,
              onChanged: (SignIN? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            subtitle:
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing"),
          ),
        ),
        SizedBox(
          height: 20,
          width: 20,
        ),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(border: Border.all(width: 1.5)),
          child: ListTile(
            subtitle:
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing"),
            style: ListTileStyle.list,
            title: Row(
              children: [
                Image.asset(
                  'assets/transporter.png',
                  height: 50,
                  width: 50,
                ),
                Text("   Transporter"),
              ],
            ),
            leading: Radio<SignIN>(
              value: SignIN.transporter,
              groupValue: _character,
              onChanged: (SignIN? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
            onPressed: null,
            style: ButtonStyle(
               shape: Utils.buttomShape,
                fixedSize: MaterialStateProperty.all(Size(280, 50)),
                backgroundColor:
                    MaterialStateProperty.all(Apptheme.continuesButtonColor),
                foregroundColor: MaterialStateProperty.all(Colors.white)),
            child: Text('continue')),
        Spacer()
      ]),
    ));
  }
}
