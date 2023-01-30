import 'package:blog_app_firebase/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/round_button.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  FirebaseAuth _auth = FirebaseAuth.instance ;


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
          title: Text('Log in to Account'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 20.0),
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
                    SizedBox(height: 30,),
                    RoundButton(title: 'Login', onPress: ()async{
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          showSpinner = true;
                        });
                        try{

                          final user = await _auth.signInWithEmailAndPassword(email: email.toString().trim(),
                              password: password.toString().trim());

                          if(user != null){
                            print("Sucess");
                            toastMessage('Log in successful');
                            setState(() {
                              showSpinner = false;
                            });
                            Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()));
                          }
                        }catch(e){
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



  void toastMessage(String message){
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }
}
