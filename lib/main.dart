import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:tapping_quality/controllers/assessment_bo_input_controller.dart';
import 'package:tapping_quality/helpers/database_helper.dart';
// import 'package:tapping_quality/pages/assessment/assessment_result.dart';
import 'package:tapping_quality/pages/home_page.dart';
// import 'package:tapping_quality/services/assessment_input_bo_service.dart';
// import 'package:tapping_quality/services/assessment_result_service.dart';

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
