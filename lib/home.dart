
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/list.dart';
import 'package:loginpage/toast.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

TextEditingController post = TextEditingController();
TextEditingController edit = TextEditingController();
final  firestore = FirebaseFirestore.instance.collection('Post');

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,body: SingleChildScrollView(
      child: Column(children: [
      
        SizedBox(width: 320,height: 180,
          child: Padding(
            padding: EdgeInsets.only(top: 100,left: 30),
            child: TextField(controller: post,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "please text",
              ),
            ),
          ),
        ),   SizedBox(width: 320,height: 100,
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: TextField(controller: edit,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText:"text",
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {  final id = DateTime.now().microsecondsSinceEpoch.toString();
          firestore
              .doc(id)
              .set({'title': post.text, 'id': id,"edit": edit.text})
              .then((value) =>
          {ToastMessage().toastmessage(message: 'Post Added')})
              .onError((error, stackTrace) =>
              ToastMessage().toastmessage(message: error.toString())); },
          child: Padding(
            padding: EdgeInsets.only(top: 30,left: 30),
            child:
            SizedBox(
              width: 230,
              height: 50,
              child: Container(
                child: Center(
                  child: Text(
                    'post',
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
        ),GestureDetector(onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (_)=>list()));},
          child: Padding(
            padding:  EdgeInsets.only(left: 180,top: 100),
            child: Text('See All',
            ),
          ),
        )
      
      ],),
    ),);
  }
}
