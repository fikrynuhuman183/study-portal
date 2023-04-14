import 'package:flutter/material.dart';
import 'package:study_portal/screens/st_dashboard_screen.dart';
import 'package:study_portal/screens/t_dashboard_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/st_login_screen.dart';
import 'screens/login_screen.dart';
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
  static const String loginRoute = '/login';
  static const String studentLoginRoute = '/student-login';
  static const String registrationRoute = '/registration';
  static const String teacherDashboardRoute = '/teacher-dashboard';
  static const String studentDashboardRoute = '/student-dashboard';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFF3F51B5),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Color(0xFF536DFE),
              ),
              foregroundColor: MaterialStatePropertyAll(Color(0xFFFFFFFF))),
        ),
      ),
      initialRoute: mainRoute,
      routes: {
        mainRoute: (context) => WelcomeScreen(),
        loginRoute: (context) => LoginScreen(),
        studentLoginRoute: (context) => StudentLoginScreen(),
        registrationRoute: (context) => RegistrationScreen(),
        teacherDashboardRoute: (context) => TeacherDashboardScreen(),
        studentDashboardRoute: (context) => StudentDashboardScreen(),
      },
    );
  }
}
