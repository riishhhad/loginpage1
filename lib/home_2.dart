import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/list_2.dart';
import 'package:loginpage/toast.dart';

class home_2 extends StatefulWidget {
  const home_2({super.key});

  @override
  State<home_2> createState() => _home_2State();
}

TextEditingController post = TextEditingController();
TextEditingController viwe = TextEditingController();
final  firestore = FirebaseFirestore.instance.collection('Post');


class _home_2State extends State<home_2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.deepOrange,body: SingleChildScrollView(
      child: Column(children: [
        SizedBox(height:160 ,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(controller: post,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: "Search of Books",
            ),
          ),
        ),SizedBox(height: 15,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(controller: viwe,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: "Search of Books",
            ),
          ),
        ), Padding(
          padding:  EdgeInsets.only(top: 50),
          child: SizedBox(
            width: 230,
            height: 50,
            child: TextButton(onPressed: (){
              final id = DateTime.now().microsecondsSinceEpoch.toString();
              firestore
                  .doc(id)
                  .set({'title': post.text, 'id': id,"edit": viwe.text})
                  .then((value) =>
              {ToastMessage().toastmessage(message: 'Post Added')})
                  .onError((error, stackTrace) =>
                  ToastMessage().toastmessage(message: error.toString()));
            },
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
        ),TextButton(
          onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (_)=>list_2())); },
          child: Padding(
            padding:  EdgeInsets.only(left: 180,top: 100),
            child: Text('See All',
            ),
          ),
        ),
      
      
      ],),
    ),);
  }
}
