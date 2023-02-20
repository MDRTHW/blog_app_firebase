import 'package:blog_app_firebase/components/round_button.dart';
import 'package:blog_app_firebase/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String email = "", password = "";
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Account'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Register',
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
                      decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                          border: OutlineInputBorder()),
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        return value!.isEmpty ? 'enter email' : null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        return value!.isEmpty ? 'enter Password' : null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RoundButton(
                        title: 'Register',
                        onPress: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final user =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email.toString().trim(),
                                      password: password.toString().trim());

                              if (user != null) {
                                print("Sucess");
                                toastMessage('User successfully created');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LogIn()));
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            } catch (e) {
                              print(e.toString());
                              toastMessage(e.toString());
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          }
                        }),
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
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
