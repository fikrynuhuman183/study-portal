import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_portal/main.dart';
import 'package:study_portal/constants.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController emailController;

  late TextEditingController passwordController;

  late TextEditingController confirmPasswordController;
  late TextEditingController nameController;
  String registrationError = '';
  String role = 'student';

  @override
  void initState() {
    // TODO: implement initState
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  Future<String> registerUser() async {
    if (passwordController.text == confirmPasswordController.text) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((currentUser) {
          print(currentUser.user?.uid);
          FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.user?.uid)
              .set({
            'uid': currentUser.user?.uid,
            'name': nameController.text,
            'role': role,
          });
        });
        if (role == 'student') {
          Navigator.pushNamedAndRemoveUntil(
              context, MyApp.studentDashboardRoute, (route) => false);
          // Navigator.pushNamed(context, MyApp.studentDashboardRoute);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, MyApp.teacherDashboardRoute, (route) => false);
          // Navigator.pushNamed(context, MyApp.teacherDashboardRoute);
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          registrationError = e.message!;
        });
        return 'error';
      }
    }
    return role;
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(registrationError),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: nameController,
                  decoration: textFieldDecoration.copyWith(
                    labelText: 'Name',
                  ),
                  autofocus: true,
                ),
              ),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: confirmPasswordController,
                  decoration: textFieldDecoration.copyWith(
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'I am a',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  DropdownButton(
                    alignment: AlignmentDirectional.topEnd,
                    value: role,
                    items: [
                      DropdownMenuItem(
                        child: Text('Student'),
                        value: 'student',
                      ),
                      DropdownMenuItem(
                        child: Text('Teacher'),
                        value: 'teacher',
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        role = value!;
                      });
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        var status = await registerUser();

                        if (status != 'error') {
                          setState(() {
                            emailController.clear();
                            nameController.clear();
                            confirmPasswordController.clear();
                            passwordController.clear();
                          });
                        } else {
                          print('Error');
                        }
                      },
                      child: Text('Register'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
