import 'package:flutter/material.dart';
import 'package:flutter_admin/common/widget/size.dart';
import 'package:flutter_admin/features/auth/auth_service.dart';
import 'package:flutter_admin/features/dashboard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    await AuthService.instance
        .authenticate(username: username, password: password)
        .then(
          (res) => {
            if (res.token != '')
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dashboard(
                      authInfo: res,
                    ),
                  ),
                )
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.signin,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              TextField(
                controller: userNameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.username,
                ),
              ),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.password,
                ),
              ),
              spaceHeight(10),
              Row(children: [
                Checkbox(
                    activeColor: Colors.lightGreen,
                    value: check,
                    onChanged: (value) => setState(() {
                          check = value!;
                        })),
                Text(
                  AppLocalizations.of(context)!.rememberMe,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ]),
              spaceHeight(30),
              ElevatedButton(
                onPressed: () {
                  handleLogin();
                },
                child: Text(
                  AppLocalizations.of(context)!.signin,
                  // style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
