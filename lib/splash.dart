import 'package:flutter/material.dart';
import 'package:loginpage/sign_in.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4),(){
      Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>sign_in()));
    });
    // TODO: implement initState
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,body: Column(children: [
      Stack(children: [Image.asset('assets/1.png'),Center(child: Padding(
        padding:  EdgeInsets.only(top: 250),
        child: SizedBox(width: 300,height:200,child: (Image.asset('assets/2.png'))),
      ))],)
    ],),);
  }
}
