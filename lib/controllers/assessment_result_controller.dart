import 'package:get/get.dart';
import 'package:tapping_quality/services/assessment_result_service.dart';

class AssessmentResultController extends GetxController {
  var assessmentResult = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAssessmentResult();
  }

  void fetchAssessmentResult() async {
    final service = AssessmentResultService();
    final data = await service.getAssessmentResult();

    assessmentResult.assignAll(data);
    print('Assessment Result: $assessmentResult');
  }
}
