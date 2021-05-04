import 'package:flutter/material.dart';
import 'package:sharedpref/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dataAssisten.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _username = TextEditingController();
  TextEditingController _pass = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff348f50), Color(0xff56b4d3)])),
            child: Center(
              child: Container(
                height: 250,
                width: 320,
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                            controller: _username,
                            decoration: InputDecoration(hintText: 'Username')),
                        TextField(
                            obscureText: true,
                            controller: _pass,
                            decoration: InputDecoration(hintText: 'Password')),
                        SizedBox(height: 30),
                        ElevatedButton(
                          child: Text('Login'),
                          onPressed: _login,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }

  Future<void> _login() async {

    if (_username.text.isNotEmpty && _pass.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      Future.delayed(Duration(seconds: 1), () {
        for (int id = 0; id < dataAssisten.length; id++) {
          if (_username.text == dataAssisten[id]["UserName"] &&
              _pass.text == dataAssisten[id]["PassWord"]) {
            String fullname = dataAssisten[id]["FullName"];
            String username =dataAssisten[id]["UserName"];
            prefs.setBool('isUser', true);
            prefs.setString('username', username);
            prefs.setString('fullname', fullname);
            Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
          }
        }
      });
    }
  }
}
