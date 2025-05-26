import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tapping_quality/helpers/database_helper.dart';

class AssessmentDetailHoService extends GetxController {
  Future<Map<String,dynamic>> insertAssessmentDetails(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    final id = await db.insert(
      'assessment_details',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // print('Inserting data: $data');

    return {
      'id': id,
      'tanggal_inspeksi': data['tanggal_inspeksi'],
    };
  }
}