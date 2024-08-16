import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/verification.dart';
import 'package:loginpage/toast.dart';

class number extends StatefulWidget {
  const number({Key? key}) : super(key: key);

  @override
  State<number> createState() => _numberState();
}

TextEditingController phone = TextEditingController();
FirebaseAuth auth = FirebaseAuth.instance;

class _numberState extends State<number> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: Column(children: [

      SizedBox(height: 140,),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(controller: phone,
          style: TextStyle(color: Colors.purple),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: "Mobail number",
            prefixIcon: Icon(Icons.contact_page_sharp),
          ),
        ),
      ), GestureDetector(onTap: () async{
        print("hello");
        auth.verifyPhoneNumber(phoneNumber: phone.text,verificationCompleted:(_){}, verificationFailed: (e) {
          ToastMessage().toastmessage(message: e.toString());
        },
            codeSent: (String verificationId,int? token){
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>verification(verificationId: verificationId,)));
            },
            codeAutoRetrievalTimeout: (e){
              ToastMessage().toastmessage(message: e.toString());
            });
      },
        child: Padding(
          padding: EdgeInsets.only(top: 30),
          child: SizedBox(
            width: 340,
            height: 50,
            child: Container(
              child: Center(
                child: Text(
                  'Get otp',
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
    ],),);
  }
}
