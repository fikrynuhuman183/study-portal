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
                Navigator.pushNamed(context, MyApp.teacherLoginRoute);
              },
              child: Text('I am a Teacher'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyApp.studentLoginRoute);
              },
              child: Text('I am a Student'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyApp.registrationRoute);
              },
              child: Text('I am a Student'),
            ),
          ],
        ),
      ),
    );
  }
}
