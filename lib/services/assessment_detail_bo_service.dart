import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tapping_quality/helpers/database_helper.dart';

class AssessmentDetailBoService extends GetxController {

  Future<int> insertAssessmentDetails(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    print('Inserting data: $data');

    return await db.insert(
      'assessment_details',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
