import 'dart:async';

import 'package:blog_app_firebase/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'option_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    final user = auth.currentUser;

    if(user != null){
      Timer(Duration(seconds: 3),
          ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())));
    }
    else{
      Timer(Duration(seconds: 3),
              ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => OptionScreen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.deepOrange,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              height: MediaQuery.of(context).size.height * .3,
              width: MediaQuery.of(context).size.width * .7,
              image: AssetImage('images/bloglogo_nob.png'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Text('Blog!',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 30,
                      fontWeight: FontWeight.w300)),
            )
          ],
        ),
      ),
    );
  }
}
