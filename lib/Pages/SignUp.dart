import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:app_conference/Pages/LoginPage.dart';
import 'package:app_conference/Services/conference_database.dart';
import 'package:app_conference/models/login.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key, this.logins}) : super(key: key);
  final Login? logins;
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  //controller
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cpasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _databaseService = DatabaseService();

  Future<void> _onSave() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final cpassword = _cpasswordController.text;
    final name = _nameController.text;

    widget.logins == null;

    //insert user credential into database
    await _databaseService
        .insertlogin(Login(username: username, password: password));

    //alert dialog will show successful sign up and forward to sign in page

    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: 'You have successfully Registered',
      title: 'Success',
      onConfirmBtnTap: () {
        (Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
            fullscreenDialog: true,
          ),
        ));
      },
    );

    bool _obsecureText = true;
    bool _cobsecureText = true;
    //design of sign up page
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.deepPurple.shade900,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'SIGN UP',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Image.asset(
                  'Images/cocktail.gif',
                  height: 250,
                  width: 300,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Welcome',
                      style: TextStyle(
                          color: Colors.white60,
                          fontSize: 18,
                          fontFamily: 'Oswald',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
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
                            controller: _usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.only(top: 14),
                              prefixIcon: Icon(
                                Icons.emoji_people,
                                color: Colors.deepPurple.shade800,
                              ),
                              hintText: 'Username',
                              hintStyle: TextStyle(color: Colors.black38),
                            ),

                            //validator for username
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '  Username is required';
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
                            controller: _passwordController,
                            obscureText: _cobsecureText,

                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _cobsecureText = !_cobsecureText;
                                  });
                                },
                                child: Icon(_cobsecureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              prefixIcon: Icon(
                                Icons.vpn_key,
                                color: Colors.deepPurple.shade800,
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.black38),
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
                            controller: _cpasswordController,
                            obscureText: _obsecureText,

                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.vpn_key,
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
                                child: Icon(_obsecureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              hintText: 'Re-enter Password',
                              hintStyle: TextStyle(color: Colors.black38),
                            ),

                            //validator for password
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'Confirm Password is not matched';
                              } else if (value == null || value.isEmpty) {
                                return 'Confirm Password is required';
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
                          padding: EdgeInsets.symmetric(vertical: 25),
                          width: double.infinity,
                          child: RaisedButton(
                            elevation: 5,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _onSave();

                                print(_usernameController.text);
                                print(_passwordController.text);
                                print('success');
                              }
                            },
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Colors.white,
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.deepPurple.shade900,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            const Text('Have an account already?',
                                style: TextStyle(color: Colors.white)),
                            FlatButton(
                              textColor: Colors.white,
                              child: const Text('Sign In'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      //forward to sign in page for registered user
                                      builder: (context) => const LoginPage()),
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
