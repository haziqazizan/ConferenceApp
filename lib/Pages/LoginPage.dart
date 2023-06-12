// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:app_conference/Pages/SignUp.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:app_conference/Pages/homeConference.dart';
import 'package:app_conference/Services/conference_database.dart';
import 'package:app_conference/models/login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  // get child => null;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  String usern = ".";
  String passw = ".";
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  static final List<Login> _signIn = [];
  final DatabaseService _databaseService = DatabaseService();
  bool isRememberMe = false;

  Future<List<Login>> _getSignIn() async {
    await _databaseService.checkUser(usern, passw).then((value) {
      //if there is value, the alert dialog will show successful sign in and forward to home page
      if (value) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: 'Your Login is Successful',
          title: 'Success',
          onConfirmBtnTap: () {
            (Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomeConference(),
                fullscreenDialog: true,
              ),
            ));
          },
        );
        //else it will show error
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: 'You don\'t have an account',
          title: 'Error',
          confirmBtnText: 'Okay',
        );
      }
    });

    //sign in the user
    return _signIn;
  }

  Widget RememberBox() {
    return Container(
      height: 20,
      child: Row(
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.purple,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  isRememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Remember Me',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  bool _obsecureText = true;
  //design of sign in page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'EASY CONFERENCE',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Image.asset(
                'Images/bubble-gum-workflow.gif',
                height: 250,
                width: 200,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'GOOD AFTERNOON',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.wb_sunny,
                    color: Colors.orangeAccent,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 2))
                            ]),
                        height: 60,
                        child: TextFormField(
                          controller: username,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.people_alt,
                              color: Colors.deepPurple.shade800,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Username',
                          ),

                          //validator for username
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username is required';
                            }
                            return null;
                          },

                          style: const TextStyle(fontSize: 15.0),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 2))
                            ]),
                        height: 60,
                        child: TextFormField(
                          controller: password,
                          obscureText: _obsecureText,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.vpn_key_rounded,
                              color: Colors.deepPurple.shade800,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obsecureText = !_obsecureText;
                                });
                              },
                              child: Icon(
                                _obsecureText
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off,
                              ),
                            ),
                            hintText: 'Password',
                          ),

                          //validator for password
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },

                          style: const TextStyle(fontSize: 15.0),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RememberBox(),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 5,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              usern = username.text;
                              passw = password.text;
                              _getSignIn();
                              print(usern);
                              print(passw);
                              print('success');
                            }
                          },
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.white,
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                color: Colors.deepPurple.shade800,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          const Text("Don't have an account?",
                              style: TextStyle(color: Colors.white)),
                          FlatButton(
                            textColor: Colors.white,
                            child: const Text('Sign Up'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    //forward to sign up page for unregistered user
                                    builder: (context) => const SignUpForm()),
                              );
                            },
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
