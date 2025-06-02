import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tapping_quality/controllers/assessment_bo_input_controller.dart';
import 'package:tapping_quality/helpers/database_helper.dart';
import 'package:tapping_quality/pages/home_page.dart';
// import 'package:tapping_quality/pages/assessment/assessment_result.dart';
// import 'package:tapping_quality/pages/home_page.dart';
import 'package:tapping_quality/pages/login_page.dart';

// import 'package:tapping_quality/services/assessment_input_bo_service.dart';
// import 'package:tapping_quality/services/assessment_result_service.dart';

Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await DatabaseHelper().deleteDatabaseFile();
  // await DatabaseHelper().checkTables();
  // List<Map<String, dynamic>> users = await DatabaseHelper().getAllUsers();

  // await AssessmentInputBoService().getCriteria();
  // final listCriteria = Get.put(AssessmentBoInputController());
  // listCriteria.fetchAssessmentDetails();
  // await AssessmentBoInputController().fetchCriteria();

  // List<Map<String, dynamic>> treeAssessment =
  //     await AssessmentResultService().getAssessmentResultTest();
  // print('Result in local: $treeAssessment');

  // print('Users in the database: $users');

  // final List<Map<String, dynamic>> data =
  //     await DatabaseHelper().getAllAssessmentDetails();
  // print('Assessment Details in the database: $data');

  await DatabaseHelper().database; // Initialize the database
  bool loggedIn = await isLoggedIn();
  runApp(MyApp(loggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  final bool loggedIn;
  const MyApp({super.key, required this.loggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: loggedIn ? HomePage() : LoginPage(),
    );
  }
}
