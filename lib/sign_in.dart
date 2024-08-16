

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loginpage/home.dart';
import 'package:loginpage/imageuplode.dart';
import 'package:loginpage/number.dart';
import 'package:loginpage/home_2.dart';
import 'package:loginpage/list.dart';
import 'package:loginpage/verification.dart';
import 'package:loginpage/sign_up.dart';
import 'package:loginpage/toast.dart';

import 'forget.dart';

class sign_in extends StatefulWidget {
  const sign_in({super.key});

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {

  TextEditingController email = TextEditingController();
  TextEditingController passwerd = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
        ToastMessage()
            .toastmessage(message: "Registreard");
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>imageuplode()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        ToastMessage()
            .toastmessage(message: e.toString());
        // handle the error here
      }
    }

    return user;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: SizedBox(
                      width: 320,
                      height: 150,
                      child: Image.asset('assets/2.png')),
                )),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: Color(0xFF471AA0),
                      fontSize: 30,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(controller: email,
                style: TextStyle(color: Colors.deepPurple),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Email or User Name',
                  prefixIcon: Icon(Icons.contact_page),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(controller: passwerd,
                style: TextStyle(color: Colors.deepPurple),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
            ),
            GestureDetector(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>forget()));},
              child: Padding(
                padding: EdgeInsets.only(left: 200, top: 30),
                child: Text(
                  'Forget Password ?',
                  style: TextStyle(
                    color: Color(0xFF471AA0),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                auth.signInWithEmailAndPassword(email: email.text,
                    password: passwerd.text).then((value) =>
                {
                  ToastMessage()
                      .toastmessage(message: 'Successfully registerd')

                }).onError((error, stacktrace) =>
                    ToastMessage()
                        .toastmessage(message: error.toString()));
              },
              child:
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: SizedBox(
                  width: 340,
                  height: 50,
                  child: Container(
                    child: Center(
                      child: Text(
                        'Sign in',
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
            Padding(
              padding: EdgeInsets.only(top: 110, left: 100),
              child: Row(
                children: [
                  Text(
                    'Don’t have account ? ',
                    style: TextStyle(
                      color: Color(0xFF471AA0),
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  GestureDetector(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>sign_up()));},
                    child: Text(
                      'Sing Up',
                      style: TextStyle(
                        color: Color(0xFF471AA0),
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(onTap: (){signInWithGoogle(context: context);},
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: SizedBox(
                          width: 150,
                          height: 50,
                          child: Image.asset('assets/3.png')),
                    ),
                    GestureDetector(onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_)=>number()));
                    },
                      child:
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: SizedBox(
                            width: 150,
                            height: 50,
                            child: Image.asset('assets/4.png')),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
