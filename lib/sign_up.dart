import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/sign_in.dart';
import 'package:loginpage/toast.dart';

class sign_up extends StatefulWidget {
  const sign_up({super.key});

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  TextEditingController email = TextEditingController();
  TextEditingController passwerd = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,body: SingleChildScrollView(
      child: Column(children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15,top: 20),
              child: Icon(Icons.arrow_back_ios_new),
            ),Padding(
              padding: EdgeInsets.only(top: 20),
              child: GestureDetector(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>sign_in()));},
                child: Text(
                  'Back',
                  style: TextStyle(
                    color: Color(0xFF471AA0),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 60,left: 18),
              child: Text(
                'Sign Up',
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
        ),SizedBox(height: 25,),
       SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(controller: email,
            style: TextStyle(color: Colors.purple),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText:  'Email',
              prefixIcon: Icon(Icons.email),
            ),
          ),
        ), SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(controller: passwerd,
            style: TextStyle(color: Colors.purple),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText:  'Password',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
        ),
        SizedBox(height: 10,),
         TextButton(
    onPressed: ()async {
    auth.createUserWithEmailAndPassword(email: email.text,
    password: passwerd.text).then((value) =>
    {
    ToastMessage()
        .toastmessage(message: 'Successfully registerd')
    }).onError((error, stacktrace) =>
    ToastMessage()
        .toastmessage(message: error.toString()));
    },child:
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: SizedBox(width: 340,height: 50,
            child: Container(child: Center(
              child: Text(
                'Sign up',
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
          padding:  EdgeInsets.only(top: 110,left: 100),
          child: Row(
            children: [
              Text(
                'Already have an account ? ',
                style: TextStyle(
                  color: Color(0xFF471AA0),
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),Text(
                'Sing up',
                style: TextStyle(
                  color: Color(0xFF471AA0),
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              )
            ],
          ),
        ),Padding(
          padding:  EdgeInsets.only(top: 15,left: 15),
          child: Row(
            children: [
              Padding(
                padding:EdgeInsets.only(left: 20),
                child: SizedBox(
                    width: 150, height: 50, child: Image.asset('assets/3.png')),
              ),
                Padding(
                  padding:  EdgeInsets.only(left: 20),
                  child: SizedBox(
                      width: 150, height: 50, child: Image.asset('assets/4.png')),
                ),

            ],
          ),
        ),
      ],),
    ),);
  }
}
