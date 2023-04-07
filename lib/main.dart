import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/st_login_screen.dart';
import 'screens/t_login_screen.dart';
import 'screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String mainRoute = '/';
  static const String teacherLoginRoute = '/teacher-login';
  static const String studentLoginRoute = '/student-login';
  static const String registrationRoute = '/registration';
  static const String teacherDashboardRoute = '/teacher-dashboard';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData.dark(),
      initialRoute: mainRoute,
      routes: {
        mainRoute: (context) => WelcomeScreen(),
        teacherLoginRoute: (context) => TeacherLoginScreen(),
        studentLoginRoute: (context) => StudentLoginScreen(),
        registrationRoute: (context) => RegistrationScreen(),
        // teacherDashboardRoute: (context) => TeacherDashboard(),
      },
    );
  }
}
