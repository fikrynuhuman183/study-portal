import 'package:flutter/material.dart';
import 'package:study_portal/main.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teach & Learn'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyApp.loginRoute);
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyApp.registrationRoute);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
