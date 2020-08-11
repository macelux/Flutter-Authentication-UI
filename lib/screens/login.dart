import 'package:authentication_ui/screens/homePage.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: <Widget>[
                FlutterLogo(colors: Colors.red, size: 120),
                SizedBox(height: 40),
                TextFormField(
                    decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                  hintText: 'Username',
                )),
                SizedBox(height: 15),
                TextFormField(
                    decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                  hintText: 'Password',
                )),
                SizedBox(height: 15),
                MaterialButton(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w300),
                  ),
                  color: Colors.red,
                  minWidth: 500,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  onPressed: () => { signIn(usernameController.text, passwordController.text) },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signIn(String email, password) async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => MainPage()),
        (Route<dynamic> route) => false);
  }
}
