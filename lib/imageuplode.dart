import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginpage/image_seeall.dart';
import 'package:loginpage/toast.dart';

class imageuplode extends StatefulWidget {
  const imageuplode({super.key});

  @override
  State<imageuplode> createState() => _imageuplodeState();
}

class _imageuplodeState extends State<imageuplode> {

  File? _image;
  final picker = ImagePicker();


  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  final databaseReference = FirebaseFirestore.instance.collection('Image');
  Future<void> getGalleryImage() async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image found');
      }
    });
  }

  Future<void> getCameraImage() async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image found');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 22, left: 25),
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    getGalleryImage();
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    child: Icon(
                                      Icons.perm_media,
                                      size: 50,
                                    ),
                                    width: 120,
                                    height: 140,
                                    decoration: ShapeDecoration(
                                        color: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15))),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 45),
                                  child: TextButton(
                                    onPressed: () {
                                      getCameraImage();
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      child: Icon(
                                        Icons.photo_camera,
                                        size: 50,
                                      ),
                                      width: 120,
                                      height: 140,
                                      decoration: ShapeDecoration(
                                          color: Colors.grey,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(15))),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 30, top: 140),
              child: SizedBox(
                  width: 180,
                  height: 200,
                  child: _image == null
                      ? Image.asset('assets/6.png')
                      : Image.file(_image!)),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 100, top: 50),
                child: Container(
                  child: Center(
                    child: TextButton(onPressed: () async {
                      final id = DateTime
                          .now()
                          .microsecondsSinceEpoch
                          .toString();
                      firebase_storage.Reference ref = firebase_storage
                          .FirebaseStorage.instance
                          .ref('/foldername/' + id);
                      firebase_storage.UploadTask uploadTask = ref.putFile(
                          _image!.absolute);
                      await Future
                          .value(uploadTask)
                          .then((value) async {
                        var newUrl = await ref.getDownloadURL();
                        print(newUrl.toString());
                        databaseReference.doc(id).set({
                        'id': id,
                        'title': newUrl.toString()
                        }).then((value) => ToastMessage().toastmessage(message: 'Uploaded'));
                      });

                      },
                      child: Text(
                        'uplode',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  width: 200,
                  height: 60,
                  decoration: ShapeDecoration(
                      color: Colors.pink,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
            ],
          ),TextButton(
            onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (_)=>image_seeall()));},
            child: Padding(
              padding:  EdgeInsets.only(left: 120,top: 100),
              child: Text(
                'SeeAll',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
