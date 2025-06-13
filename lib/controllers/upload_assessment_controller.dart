import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapping_quality/services/assessment_upload_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UploadAssessmentController extends GetxController {
  var assessmentDetails = <Map<String, dynamic>>[].obs;
  var treeAssessment = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAssessmentDetails();
  }

  void getAssessmentDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;
    final service = AssessmentUploadService();
    final data = await service.getAssessmentDetails(userId);
    assessmentDetails.assignAll(data);
    // print('userId: $userId');
    // print('Assessment Details: $assessmentDetails');
  }

  void uploadAssessment(Map<String, dynamic> data) async {
    final url = Uri.parse('http://192.168.100.23:8000/api/assessment/upload');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'assessment_code': data['assessment_code'],
          'nik_penyadap': data['nik_penyadap'],
          'blok': data['blok'],
          'task': data['task'],
          'kemandoran': data['kemandoran'],
          'no_hancak': data['no_hancak'],
          'tahun_tanam': data['tahun_tanam'],
          'clone': data['clone'],
          'sistem_sadap': data['sistem_sadap'],
          'panel_sadap': data['panel_sadap'],
          'jenis_kulit_pohon': data['jenis_kulit_pohon'],
          'tanggal_inspeksi': data['tanggal_inspeksi'],
          'inspection_by': data['inspection_by'],
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successfully uploaded
        print('Assessment uploaded successfully');
        getAssessmentDetails(); // Refresh the assessment details
      } else {
        // Handle error
        print('Failed to upload assessment: ${response.body}');
      }
    } catch (e) {
      print('Error uploading assessment: $e');
    }
  }
}
