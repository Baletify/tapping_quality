import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapping_quality/helpers/database_helper.dart';
import 'package:tapping_quality/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await DatabaseHelper().deleteDatabaseFile();
  // await DatabaseHelper().checkTables();
  // List<Map<String, dynamic>> users = await DatabaseHelper().getAllUsers();

  // print('Users in the database: $users');

  final List<Map<String, dynamic>> data =
      await DatabaseHelper().getAllAssessmentDetails();
  print('Assessment Details in the database: $data');

  await DatabaseHelper().database; // Initialize the database
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
