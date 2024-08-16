import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:loginpage/home.dart';

class verification extends StatefulWidget {
  final verificationId;

  const verification({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<verification> createState() => _phoneState();
}

TextEditingController verificationcode = TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;

class _phoneState extends State<verification> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,body: SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding:  EdgeInsets.only(top: 180),
          child: OtpTextField(
            numberOfFields: 6,
            borderColor: Color(0xFF512DA8),
            showFieldAsBox: true,
            onCodeChanged: (String code) {
            },
            onSubmit: (String verificationCode){
              showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text("Verification Code"),
                      content: Text('Code entered is $verificationCode'),
                    );
                  }
              );
            }, // end onSubmit
          ),
        ),  GestureDetector(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>home()));},
          child: Padding(
            padding: EdgeInsets.only(top:60),
            child: SizedBox(
              width: 230,
              height: 50,
              child: Container(
                child: Center(
                  child: Text(
                    'verify',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
                width: 390,
                height: 50,
                decoration: ShapeDecoration(
                  color: Color(0xFFBB84E8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],),
    ),);
  }
}
