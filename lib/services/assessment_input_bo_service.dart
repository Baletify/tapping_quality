import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
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
    // print('Criteria: $result');
    return result;
  }

  Future<void> insertAssessment(List<Map<String, dynamic>> dataList) async {
    final db = await DatabaseHelper().database;
    // print('Inserting data: $data');

    for (final data in dataList) {
      await db.insert(
        'tree_assessments',
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getTreeAssessment() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT * FROM tree_assessments ORDER BY assessment_detail_id DESC',
    );
    return result;
  }
}
