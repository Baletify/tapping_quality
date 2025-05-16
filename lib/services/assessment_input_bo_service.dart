import 'package:get/get.dart';
import 'package:tapping_quality/helpers/database_helper.dart';

class AssessmentInputBoService extends GetxController {
  Future<List<Map<String, dynamic>>> getFirst() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT assessment_details.*, users.nik, users.name, users.kemandoran, users.departemen FROM assessment_details LEFT JOIN users ON assessment_details.nik_penyadap = users.nik ORDER BY assessment_details.id DESC',
    );
    return result;
  }

  Future<List<Map<String, dynamic>>> getCriteria() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT * FROM criteria ORDER BY id ASC',
    );
    print('Criteria: $result');
    return result;
  }
}
