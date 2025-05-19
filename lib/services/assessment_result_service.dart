import 'package:get/get.dart';
import 'package:tapping_quality/helpers/database_helper.dart';

class AssessmentResultService extends GetxController {
  Future<List<Map<String, dynamic>>> getAssessmentResult() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT assessment_details.nik_penyadap, users.name, users.kemandoran, users.departemen, assessment_details.task, assessment_details.jenis_kulit_pohon FROM assessment_details LEFT JOIN users ON assessment_details.nik_penyadap = users.nik ORDER BY assessment_details.id DESC',
    );
    // print('Assessment Result: $result');
    return result;
  }
}
