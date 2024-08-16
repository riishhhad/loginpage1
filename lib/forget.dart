import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/toast.dart';

class forget extends StatefulWidget {
  const forget({Key? key}) : super(key: key);

  @override
  State<forget> createState() => _forgetState();
}
TextEditingController email = TextEditingController();
final auth = FirebaseAuth.instance;

class _forgetState extends State<forget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,body: Column(children: [
      SizedBox(height: 250,),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(controller: email,
          style: TextStyle(color: Colors.deepPurple),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
        ),
      ), TextButton(
        onPressed: () { auth.sendPasswordResetEmail(email: email.text).then((value){
ToastMessage().toastmessage(message: 'password changed successfully');
        }).onError((error,StackTrace){
          ToastMessage().toastmessage(message: error.toString());
        }); },
        child: Padding(
          padding: EdgeInsets.only(top: 30),
          child: SizedBox(width: 340,height: 50,
            child: Container(child: Center(
              child: Text(
                'reset',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
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
