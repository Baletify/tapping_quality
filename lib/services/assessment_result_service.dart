import 'package:get/get.dart';
import 'package:tapping_quality/helpers/database_helper.dart';

class AssessmentResultService extends GetxController {
  Future<List<Map<String, dynamic>>> getAssessmentResult(
    int id,
    dynamic date,
  ) async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT assessment_details.nik_penyadap, users.name, users.kemandoran, users.departemen, assessment_details.task, assessment_details.jenis_kulit_pohon, AVG(criteria.score) as avg_score FROM assessment_details LEFT JOIN users ON assessment_details.nik_penyadap = users.nik LEFT JOIN tree_assessments ON assessment_details.id = tree_assessments.assessment_detail_id LEFT JOIN criteria ON criteria.id = tree_assessments.criteria_id WHERE assessment_details.id = ? AND assessment_details.tanggal_inspeksi = ?',
      [id, date],
    );
    print('Assessment Result: $result');
    return result;
  }

  // Future<List<Map<String, dynamic>>> getAssessmentResultTest() async {
  //   final db = await DatabaseHelper().database;
  //   final List<Map<String, dynamic>> result = await db.rawQuery(
  //     'SELECT assessment_details.nik_penyadap, users.name, users.kemandoran, users.departemen, assessment_details.task, assessment_details.jenis_kulit_pohon, AVG(criteria.score) as avg_score FROM assessment_details LEFT JOIN users ON assessment_details.nik_penyadap = users.nik LEFT JOIN tree_assessments ON assessment_details.id = tree_assessments.assessment_detail_id LEFT JOIN criteria ON criteria.id = tree_assessments.criteria_id',
  //   );
  //   print('Assessment Result: $result');
  //   return result;
  // }

  Future<List<Map<String, dynamic>>> getAssessmentReport(
    String nik,
    dynamic date,
  ) async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT assessment_details.nik_penyadap, users.name, users.kemandoran, users.departemen, assessment_details.task, assessment_details.jenis_kulit_pohon, AVG(criteria.score) as avg_score, assessment_details.tanggal_inspeksi FROM assessment_details LEFT JOIN users ON assessment_details.nik_penyadap = users.nik LEFT JOIN tree_assessments ON assessment_details.id = tree_assessments.assessment_detail_id LEFT JOIN criteria ON criteria.id = tree_assessments.criteria_id WHERE assessment_details.nik_penyadap = ? AND DATE(assessment_details.tanggal_inspeksi) = ? ORDER BY assessment_details.tanggal_inspeksi DESC',
      [nik, date],
    );

    print('Assessment Result: $result');
    return result;
  }
}
