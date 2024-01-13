import 'package:flutter/material.dart';
import 'package:flutter_admin/features/login/auth_service.dart';
import 'package:flutter_admin/features/home/nav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool check = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  handleLogin() async {
    final String username = userNameController.value.text;
    final String password = passwordController.value.text;
    await APIService.instance
        .authenticate(username: username, password: password)
        .then((res) => {
          if (res.token != '') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Navbar(authInfo: res,)),
            )
          }
        });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
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
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  controller: userNameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      //  when the TextFormField in focused
                    ),
                  ),
                ),
              ),
              TextField(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
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
                      value: check,
                      onChanged: (value) {
                        setState(() {
                          check = value!;
                        });
                      },
                    ),
                    const Text(
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
                    child: const Text(
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
