import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/home.dart';
import 'package:loginpage/toast.dart';

class list extends StatefulWidget {
  const list({super.key});

  @override
  State<list> createState() => _listState();
}

final result = FirebaseFirestore.instance.collection('Post').snapshots();
final refer = FirebaseFirestore.instance.collection('Post');

class _listState extends State<list> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: result,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(),);
            }
            if (snapshot.hasError) {
              return Text("error", style: TextStyle(color: Colors.black),);
            }

            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        subtitle: Text(snapshot.data!.docs[index]['edit'].toString()),
                        title: TextButton(onPressed: (){
                          var newValue;
       refer.doc(snapshot.data!.docs[index]['id'].toString())
                            .update({
                          'edit': newValue.text,
                        }).then((value) {
                          ToastMessage()
                              .toastmessage(message: 'Updated Successfully');
                          Navigator.of(context).pop();
                        }).onError((error, stackTrace) {
                          ToastMessage().toastmessage(message: error.toString());
                        });},
                          child: Padding(
                            padding:  EdgeInsets.only(top: 25),
                            child: GestureDetector(onTap: (){
                    showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                    return SizedBox(
                    height: 800,
                    child: Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      SizedBox(height: 100,width: 280,
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                            ),
                            hintText: "text",
                          ),
                        ),
                      ),

                    ],
                    ),
                    ));});},
                              child: Text(
                                'Update',
                                style:
                                TextStyle(color: Colors.purple, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                    trailing:TextButton(onPressed: (){ refer.doc(snapshot.data!.docs[index]['id'].toString()).delete();},child:Text(
                    'Delete',
                    style: TextStyle(
                    color: Colors.purple,
                    ),
                    ),

                    ));
                  });
            } else {
              return Container();
            }
          }),
    );
  }
}
