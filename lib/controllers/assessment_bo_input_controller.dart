import 'package:get/get.dart';
import 'package:tapping_quality/services/assessment_input_bo_service.dart';

class AssessmentBoInputController extends GetxController {
  var isSmallChecked = false.obs;
  var isMediumChecked = false.obs;
  var isLargeChecked = false.obs;
  var selectedDepth = ''.obs;
  var isOpt1Checked = false.obs;
  var isOpt2Checked = false.obs;
  var isOpt3Checked = false.obs;
  var isOpt4Checked = false.obs;
  var isOpt5Checked = false.obs;
  var isOpt6Checked = false.obs;
  var isOpt7Checked = false.obs;
  var selectedAngle = ''.obs;
  var selectedScrap = ''.obs;
  var selectedBlong = ''.obs;
  var selectedHealthyTree = ''.obs;
  var selectedResultTake = ''.obs;
  var selectedTalangSadap = ''.obs;
  var isTool1Checked = false.obs;
  var isTool2Checked = false.obs;
  var isTool3Checked = false.obs;
  var isCleanedTool1Checked = false.obs;
  var isCleanedTool2Checked = false.obs;
  var assessmentDetails = <Map<String, dynamic>>[].obs;
  var criteria = <Map<String, dynamic>>[].obs;
  var selectedCriteriaIds = <int>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchAssessmentDetails();
    fetchCriteria();
  }

  void fetchAssessmentDetails() async {
    final service = AssessmentInputBoService();
    final data = await service.getFirst();

    assessmentDetails.assignAll(data);
    // print('Assessment Details: $assessmentDetails');
  }

  void fetchCriteria() async {
    final service = AssessmentInputBoService();
    final data = await service.getCriteria();

    criteria.assignAll(data);
  }

  void resetState() {
    isSmallChecked.value = false;
    isMediumChecked.value = false;
    isLargeChecked.value = false;
    selectedDepth.value = '';
    isOpt1Checked.value = false;
    isOpt2Checked.value = false;
    isOpt3Checked.value = false;
    isOpt4Checked.value = false;
    isOpt5Checked.value = false;
    isOpt6Checked.value = false;
    isOpt7Checked.value = false;
    selectedAngle.value = '';
    selectedScrap.value = '';
    selectedBlong.value = '';
    selectedHealthyTree.value = '';
    selectedResultTake.value = '';
    selectedTalangSadap.value = '';
    isTool1Checked.value = false;
    isTool2Checked.value = false;
    isTool3Checked.value = false;
    isCleanedTool1Checked.value = false;
    isCleanedTool2Checked.value = false;
  }

  void toggleCheckbox(String size) {
    switch (size) {
      case 'small':
        isSmallChecked.value = !isSmallChecked.value;
        break;
      case 'medium':
        isMediumChecked.value = !isMediumChecked.value;
        break;
      case 'large':
        isLargeChecked.value = !isLargeChecked.value;
        break;
    }
  }

  void selectDepth(String depth) {
    selectedDepth.value = depth;
  }

  void toggleCheckbox2(String option) {
    switch (option) {
      case 'opt1':
        isOpt1Checked.value = !isOpt1Checked.value;
        break;
      case 'opt2':
        isOpt2Checked.value = !isOpt2Checked.value;
        break;
      case 'opt3':
        isOpt3Checked.value = !isOpt3Checked.value;
        break;
      case 'opt4':
        isOpt4Checked.value = !isOpt4Checked.value;
        break;
      case 'opt5':
        isOpt5Checked.value = !isOpt5Checked.value;
        break;
      case 'opt6':
        isOpt6Checked.value = !isOpt6Checked.value;
        break;
      case 'opt7':
        isOpt7Checked.value = !isOpt7Checked.value;
        break;
    }
  }

  void selectAngle(String angle) {
    selectedAngle.value = angle;
  }

  void selectScrap(String scrap) {
    selectedScrap.value = scrap;
  }

  void toggleCheckbox3(String tool) {
    switch (tool) {
      case 'Talang':
        isTool1Checked.value = !isTool1Checked.value;
        break;
      case 'Mangkok':
        isTool2Checked.value = !isTool2Checked.value;
        break;
      case 'Hanger':
        isTool3Checked.value = !isTool3Checked.value;
        break;
    }
  }

  void toggleCheckbox4(String cleanedTool) {
    switch (cleanedTool) {
      case 'Talang':
        isCleanedTool1Checked.value = !isCleanedTool1Checked.value;
        break;
      case 'Mangkok':
        isCleanedTool2Checked.value = !isCleanedTool2Checked.value;
        break;
    }
  }

  void selectBlong(String blong) {
    selectedBlong.value = blong;
  }

  void selectHealthyTree(String healthyTree) {
    selectedHealthyTree.value = healthyTree;
  }

  void selectResultTake(String resultTake) {
    selectedResultTake.value = resultTake;
  }

  void selectTalangSadap(String talangSadap) {
    selectedTalangSadap.value = talangSadap;
  }
}
