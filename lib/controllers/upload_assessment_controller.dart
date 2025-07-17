import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:tapping_quality/services/assessment_upload_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UploadAssessmentController extends GetxController {
  var assessmentDetails = <Map<String, dynamic>>[].obs;
  var uploadedAssessmentDetails = <Map<String, dynamic>>[].obs;
  var treeAssessment = <Map<String, dynamic>>[].obs;
  var isUploading = false.obs;
  var uploadingId = <String>{}.obs;
  var isUploadingMap = <String, bool>{}.obs;
  var uploadTotalMap = <String, int>{}.obs;
  var uploadCurrentMap = <String, int>{}.obs;
  var isAnyUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAssessmentDetails();
    getUploadedAssessmentDetails();
  }

  void getAssessmentDetails() async {
    // final prefs = await SharedPreferences.getInstance();
    // final userId = prefs.getInt('userId') ?? 0;
    final service = AssessmentUploadService();
    final data = await service.getAssessmentDetails();
    assessmentDetails.assignAll(data);
    // print('userId: $userId');
    // print('Assessment Details: $assessmentDetails');
  }

  void getUploadedAssessmentDetails() async {
    // final prefs = await SharedPreferences.getInstance();
    // final userId = prefs.getInt('userId') ?? 0;
    final service = AssessmentUploadService();
    final data = await service.getUploadedAssessmentDetails();
    uploadedAssessmentDetails.assignAll(data);
  }

  void uploadAssessment(Map<String, dynamic> data) async {
    isUploading.value = true;
    final url = Uri.parse('http://192.168.100.30:8000/api/assessment-upload');
    final service = AssessmentUploadService();
    final id = data['assessment_id'].toString();
    isUploadingMap[id] = true;
    uploadTotalMap[id] = 0;
    uploadCurrentMap[id] = 0;
    isAnyUploading.value = true;
    try {
      print('Uploading assessment: ${data['assessment_id']}');

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
          'jenis_sadap': data['jenis_sadap'],
          'sistem_sadap': data['sistem_sadap'],
          'panel_sadap': data['panel_sadap'],
          'jenis_kulit_pohon': data['jenis_kulit_pohon'],
          'tanggal_inspeksi': data['tanggal_inspeksi'],
          'inspection_by': data['inspection_by'],
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        uploadingId.add(data['assessment_id'].toString());
        // Successfully uploaded
        print('Assessment uploaded successfully');
        final responseData = jsonDecode(response.body);
        print('Success: ${responseData['success']}');
        print('Message: ${responseData['message']}');
        // print('Data: ${responseData['data']}');
        await service.getTreeAssessment(data['assessment_id']);
        treeAssessment.assignAll(
          await service.getTreeAssessment(data['assessment_id']),
        );
        // print('Tree Assessment: $treeAssessment');
        uploadTotalMap[id] = treeAssessment.length;
        uploadCurrentMap[id] = 0;
        for (final data in treeAssessment) {
          await http.post(
            Uri.parse('http://192.168.100.30:8000/api/tree-assessment-upload'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'assessment_code': data['assessment_code'],
              'tree_id': data['tree_id'],
              'criteria_id': data['criteria_id'],
            }),
          );
          uploadCurrentMap[id] = uploadCurrentMap[id]! + 1;
        }
        await service.updateAssessmentDetails(data['assessment_code']);
        getAssessmentDetails();
        uploadingId.remove(data['assessment_id']);
        isUploading.value = false;
        Get.snackbar(
          'Success',
          'Assessment uploaded successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        isUploadingMap[id] = false;
        uploadTotalMap[id] = 0;
        uploadCurrentMap[id] = 0;
        isAnyUploading.value = false;
      } else {
        // Handle error
        Get.snackbar(
          'Error',
          'Failed to upload assessment: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Failed to upload assessment: ${response.body}');
        uploadingId.remove(data['assessment_id']);
        isUploading.value = false;
        isUploadingMap[id] = false;
        uploadTotalMap[id] = 0;
        uploadCurrentMap[id] = 0;
        isAnyUploading.value = false;
      }
    } catch (e) {
      print('Error uploading assessment: $e');
      Get.snackbar(
        'Error',
        'An error occurred while uploading the assessment',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      uploadingId.remove(data['assessment_id']);
      isUploading.value = false;
      isUploadingMap[id] = false;
      uploadTotalMap[id] = 0;
      uploadCurrentMap[id] = 0;
      isAnyUploading.value = false;
    } finally {
      uploadingId.remove(data['assessment_id']);
      isUploading.value = false;
      getAssessmentDetails();
      isUploadingMap[id] = false;
      uploadTotalMap[id] = 0;
      uploadCurrentMap[id] = 0;
      isAnyUploading.value = false;
    }
  }
}
