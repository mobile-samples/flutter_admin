import 'package:flutter/material.dart';
import 'package:flutter_admin/src/models/auth.dart';
import 'package:flutter_admin/src/services/auth.dart';
import 'package:flutter_admin/src/widgets/nav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool check = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  handleLogin() async {
    final String username = userNameController.value.text;
    final String password = passwordController.value.text;
    final AuthInfo res = await APIService.instance
        .authenticate(username: username, password: password);
    if (res.token != '') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Navbar(
                  authInfo: res,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 140,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text(
                  'Sign in',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.green[400],
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                child: TextField(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  controller: userNameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      //  when the TextFormField in focused
                    ),
                  ),
                ),
              ),
              TextField(
                style: TextStyle(fontSize: 16, color: Colors.black),
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    //  when the TextFormField in focused
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(children: <Widget>[
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.lightGreen,
                      value: this.check,
                      onChanged: (value) {
                        setState(() {
                          this.check = value!;
                        });
                      },
                    ),
                    Text(
                      'Remember me',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ])),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      handleLogin();
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
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
