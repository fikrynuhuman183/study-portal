import 'package:flutter/material.dart';
import 'package:study_portal/constants.dart';
import 'package:study_portal/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddSubjectScreen extends StatefulWidget {
  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  late TextEditingController nameController;
  late TextEditingController gradeController;
  late TextEditingController descriptionController;
  String error = '';

  Future<void> addSubject({
    required String name,
    required String grade,
    String description = '',
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user == null) {
      Navigator.pushNamedAndRemoveUntil(
          context, MyApp.loginRoute, (route) => false);
    }
    final uid = user?.uid;
    try {
      // Add a new subject document to the teacher's subcollection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('subjects')
          .add({'name': name, 'grade': grade, 'description': description});

      Navigator.pop(context);
    } catch (e) {
      print('Error adding subject: $e');
    }
  }

  // Future<void> addSubject() async {
  //
  //
  //   try {
  //     await FirebaseFirestore.instance.collection('subjects').doc(uid).add({
  //       'name': nameController.text,
  //       'grade': gradeController.text,
  //       'teacher_id': uid
  //     });
  //     Navigator.pop(context);
  //   } on FirebaseException catch (e) {
  //     setState(() {
  //       error = e.message!;
  //     });
  //     print(e);
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    nameController = TextEditingController();
    gradeController = TextEditingController();
    descriptionController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(error),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: nameController,
                decoration: textFieldDecoration.copyWith(
                  labelText: 'Subject Name | ex: GCE A/L Physics',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: gradeController,
                decoration: textFieldDecoration.copyWith(
                  labelText: 'Grade | ex: 12',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: descriptionController,
                decoration: textFieldDecoration.copyWith(
                  labelText: 'Description',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await addSubject(
                    name: nameController.text,
                    grade: gradeController.text,
                    description: descriptionController.text);
              },
              child: Text('Add New Subject'),
            )
          ],
        ));
  }
}
