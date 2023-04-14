import 'package:flutter/material.dart';
import 'package:study_portal/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_portal/main.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String loginError = '';
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    // TODO: implement initState
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  Future<String> loginUser() async {
    setState(() {
      loginError = '';
    });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((currentUser) => FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUser.user!.uid)
                  .get()
                  .then((DocumentSnapshot result) {
                emailController.clear();
                emailController.clear();
                if (result['role'] == 'student') {
                  Navigator.pushNamedAndRemoveUntil(
                      context, MyApp.studentDashboardRoute, (route) => false);
                  // Navigator.pushNamed(context, MyApp.studentDashboardRoute);
                } else if (result['role'] == 'teacher') {
                  Navigator.pushNamedAndRemoveUntil(
                      context, MyApp.teacherDashboardRoute, (route) => false);
                  // Navigator.pushNamed(context, MyApp.teacherDashboardRoute);
                }
              }));
    } on FirebaseAuthException catch (e) {
      setState(() {
        loginError = e.message!;
      });
      return 'error';
    }

    return 'success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(loginError),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: emailController,
                  decoration: textFieldDecoration.copyWith(
                    labelText: 'Email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: passwordController,
                  decoration: textFieldDecoration.copyWith(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  var status = await loginUser();
                },
                child: Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
