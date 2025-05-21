import 'package:get/get.dart';
import 'package:tapping_quality/services/assessment_result_service.dart';

class AssessmentResultController extends GetxController {
  var assessmentResult = <Map<String, dynamic>>[].obs;
  var assessmentReport = <Map<String, dynamic>>[].obs;

  void fetchAssessmentResult(int id, dynamic date) async {
    final service = AssessmentResultService();
    final data = await service.getAssessmentResult(id, date);

    assessmentResult.assignAll(data);
    print('Assessment Result: $assessmentResult');
  }

  fetchAssessmentReport(String nik, dynamic date) async {
    final service = AssessmentResultService();
    final data = await service.getAssessmentReport(nik, date);

    assessmentReport.assignAll(data);
    print('Assessment Report: $assessmentReport');
  }
}
