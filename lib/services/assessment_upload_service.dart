import 'package:tapping_quality/helpers/database_helper.dart';

class AssessmentUploadService {
  Future<List<Map<String, dynamic>>> getAssessmentDetails(int userId) async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT assessment_details.*, tappers.* FROM assessment_details LEFT JOIN tappers ON assessment_details.nik_penyadap = tappers.nik WHERE tappers.user_id = ? AND assessment_details.foreman_upload_at IS NULL ORDER BY created_at DESC',
      [userId],
    );
    // print(userId);
    // print('Assessment Details: $result');

    return result;
  }
}
