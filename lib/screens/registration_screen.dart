import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_portal/main.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController emailController;

  late TextEditingController passwordController;

  late TextEditingController confirmPasswordController;
  late TextEditingController nameController;

  @override
  void initState() {
    // TODO: implement initState
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                autofocus: true,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'example@hash.com',
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((currentUser) => FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(currentUser.user?.uid)
                                    .set({
                                  'uid': currentUser.user?.uid,
                                  'name': nameController.text,
                                  'role': 'student',
                                }));
                        print('Done');
                      }
                    },
                    child: Text('I am a Student'),
                  ),
                  TextButton(onPressed: () {}, child: Text('I am a Teacher'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
