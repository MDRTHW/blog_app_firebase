import 'package:blog_app_firebase/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:blog_app_firebase/components/round_button.dart';

import 'login_screen.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({Key? key}) : super(key: key);

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "BlogTHW",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image(
                image: AssetImage('images/penhead.png'),
              ),
              SizedBox(
                height: 40,
              ),
              RoundButton(title: 'Login', onPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogIn()));
              }),
              SizedBox(
                height: 30,
              ),
              RoundButton(
                  title: 'Register',
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
