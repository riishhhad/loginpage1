import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class image_seeall extends StatefulWidget {
  const image_seeall({super.key});

  @override
  State<image_seeall> createState() => _image_seeallState();
}
final hlo = FirebaseFirestore.instance.collection('Image').snapshots();


class _image_seeallState extends State<image_seeall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: hlo,
        builder: (BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(),);
          }
          if (snapshot.hasError) {
            return Text("error", style: TextStyle(color: Colors.black),);
          }
          if (snapshot.hasData) {
            return SizedBox(
              child: GridView.count(
                  crossAxisCount:2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  children: List.generate(snapshot.data!.docs.length, (index) {
                    return Container(

                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(20.0),),
                      ),
                      child:Image.network(snapshot.data!.docs[index]['title'].toString(),fit: BoxFit.cover,),
                    );
                  },)),
            );
          } else {
            return Container();
          }
          }
        ),
    );
  }
}
