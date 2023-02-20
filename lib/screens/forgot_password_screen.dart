import 'package:blog_app_firebase/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/round_button.dart';
import 'home_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String email = "";
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Forgot  password'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Reset Password',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        return value!.isEmpty ? 'Please Enter an Email' : null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RoundButton(
                        title: 'Reset ',
                        onPress: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              _auth
                                  .sendPasswordResetEmail(
                                      email: emailController.text.toString())
                                  .then((value) {
                                setState(() {
                                  showSpinner = false;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LogIn()));
                                toastMessage(
                                    "Recovery mail sent. Please check you email.");
                              }).onError((error, stackTrace) {
                                setState(() {
                                  showSpinner = false;
                                });
                                toastMessage(error.toString());
                              });
                            } catch (e) {
                              print(e.toString());
                              toastMessage(e.toString());
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          }
                        }),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
