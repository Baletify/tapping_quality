import 'package:tapping_quality/helpers/database_helper.dart';

class AssessmentUploadService {
  Future<List<Map<String, dynamic>>> getAssessmentDetails(int userId) async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT assessment_details.*, assessment_details.id as assessment_id, tappers.*, tappers.id as tapper_id FROM assessment_details LEFT JOIN tappers ON assessment_details.nik_penyadap = tappers.nik WHERE tappers.user_id = ? AND assessment_details.foreman_upload_at IS NULL ORDER BY created_at DESC',
      [userId],
    );
    // print(userId);
    print('Assessment Details: $result');

    return result;
  }

  Future<List<Map<String, dynamic>>> getTreeAssessment(int assessmentId) async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT tree_assessments.*, assessment_details.assessment_code FROM tree_assessments LEFT JOIN assessment_details ON assessment_details.id = tree_assessments.assessment_detail_id WHERE assessment_detail_id = ?',
      [assessmentId],
    );
    print('Tree Assessment: $result');

    return result;
  }

  Future<List<Map<String, dynamic>>> getUploadedAssessmentDetails(
    int userId,
  ) async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT assessment_details.*, tappers.* FROM assessment_details LEFT JOIN tappers ON assessment_details.nik_penyadap = tappers.nik WHERE tappers.user_id = ? AND assessment_details.foreman_upload_at IS NOT NULL ORDER BY created_at DESC',
      [userId],
    );
    // print(userId);
    print('Uploaded Assessment Details: $result');

    return result;
  }

  Future<List<Map<String, dynamic>>> updateAssessmentDetails(
    String assessmentCode,
  ) {
    final db = DatabaseHelper().database;
    return db.then((database) async {
      final result = await database.rawQuery(
        'UPDATE assessment_details SET foreman_upload_at = datetime("now") WHERE assessment_code = ?',
        [assessmentCode],
      );
      return result;
    });
  }
}
