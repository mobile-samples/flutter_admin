import 'package:flutter/material.dart';
import 'package:flutter_admin/features/auth/auth_model.dart';
import 'package:flutter_admin/features/auth/auth_service.dart';
import 'package:flutter_admin/features/auth/widgets/login.dart';

import 'dashboard.dart';

class LandingWidget extends StatelessWidget {
  const LandingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AuthInfo>(
      future: AuthService.instance.tryAutoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Future.microtask(() => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => snapshot.hasData
                      ? Dashboard(authInfo: snapshot.requireData)
                      : const LoginScreen())));
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary),
          ),
        );
      },
    );
  }
}
