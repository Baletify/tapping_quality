import 'package:get/get.dart';
import 'package:tapping_quality/services/assessment_input_bo_service.dart';

class AssessmentBoInputController extends GetxController {
  var isWound1Checked = false.obs;
  var isWound2Checked = false.obs;
  var isWound3Checked = false.obs;
  var isWound4Checked = false.obs;
  var selectedDepth = ''.obs;
  var isOpt1Checked = false.obs;
  var isOpt2Checked = false.obs;
  var isOpt3Checked = false.obs;
  var isOpt4Checked = false.obs;
  var isOpt5Checked = false.obs;
  var isOpt6Checked = false.obs;
  var isOpt7Checked = false.obs;
  var isOpt8Checked = false.obs;
  var selectedAngle = ''.obs;
  var selectedScrap = ''.obs;
  var selectedBlong = ''.obs;
  var selectedHealthyTree = ''.obs;
  var selectedResultTake = ''.obs;
  var selectedTalangSadap = ''.obs;
  var isTool1Checked = false.obs;
  var isTool2Checked = false.obs;
  var isTool3Checked = false.obs;
  var isTool4Checked = false.obs;
  var isCleanedTool1Checked = false.obs;
  var isCleanedTool2Checked = false.obs;
  var isCleanedTool3Checked = false.obs;
  var assessmentDetails = <Map<String, dynamic>>[].obs;
  var criteria = <Map<String, dynamic>>[].obs;
  var selectedCriteriaIds = <List<int>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAssessmentDetails();
    fetchCriteria();
    selectedCriteriaIds.value = List.generate(12, (_) => []);
    resetState();
  }

  void fetchAssessmentDetails() async {
    final service = AssessmentInputBoService();
    final data = await service.getAll();

    assessmentDetails.assignAll(data);
    // print('Assessment Details: $assessmentDetails');
  }

  void fetchCriteria() async {
    final service = AssessmentInputBoService();
    final data = await service.getCriteria();

    criteria.assignAll(data);
  }

  void resetState() {
    isWound1Checked.value = false;
    isWound2Checked.value = false;
    isWound3Checked.value = false;
    isWound4Checked.value = false;
    isOpt1Checked.value = false;
    isOpt2Checked.value = false;
    isOpt3Checked.value = false;
    isOpt4Checked.value = false;
    isOpt5Checked.value = false;
    isOpt6Checked.value = false;
    isOpt7Checked.value = false;
    isOpt8Checked.value = false;
    selectedAngle.value = '';
    selectedScrap.value = '';
    selectedBlong.value = '';
    selectedHealthyTree.value = '';
    selectedResultTake.value = '';
    selectedTalangSadap.value = '';
    isTool1Checked.value = false;
    isTool2Checked.value = false;
    isTool3Checked.value = false;
    isTool4Checked.value = false;
    isCleanedTool1Checked.value = false;
    isCleanedTool2Checked.value = false;
    isCleanedTool3Checked.value = false;
  }

  void toggleWoundCheckbox(String wound) {
    switch (wound) {
      case 'Kecil':
        isWound1Checked.value = !isWound1Checked.value;
        if (isWound1Checked.value && isWound4Checked.value) {
          isWound4Checked.value = false;
        }
        break;
      case 'Sedang':
        isWound2Checked.value = !isWound2Checked.value;
        if (isWound2Checked.value && isWound4Checked.value) {
          isWound4Checked.value = false;
        }
        break;
      case 'Besar':
        isWound3Checked.value = !isWound3Checked.value;
        if (isWound4Checked.value && isWound4Checked.value) {
          isWound4Checked.value = false;
        }
        break;
      case 'OK':
        isWound4Checked.value = !isWound4Checked.value;
        if (isWound4Checked.value) {
          // Uncheck all others if "OK" is checked
          isWound1Checked.value = false;
          isWound2Checked.value = false;
          isWound3Checked.value = false;
        }
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
        if (isOpt1Checked.value && isOpt8Checked.value) {
          isOpt8Checked.value = false;
        }
        break;
      case 'opt2':
        isOpt2Checked.value = !isOpt2Checked.value;
        if (isOpt2Checked.value && isOpt8Checked.value) {
          isOpt8Checked.value = false;
        }
        break;
      case 'opt3':
        isOpt3Checked.value = !isOpt3Checked.value;
        if (isOpt3Checked.value && isOpt8Checked.value) {
          isOpt8Checked.value = false;
        }
        break;
      case 'opt4':
        isOpt4Checked.value = !isOpt4Checked.value;
        if (isOpt4Checked.value && isOpt8Checked.value) {
          isOpt8Checked.value = false;
        }
        break;
      case 'opt5':
        isOpt5Checked.value = !isOpt5Checked.value;
        if (isOpt5Checked.value && isOpt8Checked.value) {
          isOpt8Checked.value = false;
        }
        break;
      case 'opt6':
        isOpt6Checked.value = !isOpt6Checked.value;
        if (isOpt6Checked.value && isOpt8Checked.value) {
          isOpt8Checked.value = false;
        }
        break;
      case 'opt7':
        isOpt7Checked.value = !isOpt7Checked.value;
        if (isOpt7Checked.value && isOpt8Checked.value) {
          isOpt8Checked.value = false;
        }
        break;
      case 'opt8':
        isOpt8Checked.value = !isOpt8Checked.value;
        if (isOpt8Checked.value) {
          // Uncheck all others if opt8 is checked
          isOpt1Checked.value = false;
          isOpt2Checked.value = false;
          isOpt3Checked.value = false;
          isOpt4Checked.value = false;
          isOpt5Checked.value = false;
          isOpt6Checked.value = false;
          isOpt7Checked.value = false;
        }
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
        if (isTool1Checked.value && isTool4Checked.value) {
          isTool4Checked.value = false;
        }
        break;
      case 'Mangkok':
        isTool2Checked.value = !isTool2Checked.value;
        if (isTool2Checked.value && isTool4Checked.value) {
          isTool4Checked.value = false;
        }
        break;
      case 'Hanger':
        isTool3Checked.value = !isTool3Checked.value;
        if (isTool3Checked.value && isTool4Checked.value) {
          isTool4Checked.value = false;
        }
        break;
      case 'Lengkap':
        isTool4Checked.value = !isTool4Checked.value;
        if (isTool4Checked.value) {
          // Uncheck all others if "Lengkap" is checked
          isTool1Checked.value = false;
          isTool2Checked.value = false;
          isTool3Checked.value = false;
        }
        break;
    }
  }

  void toggleCheckbox4(String cleanedTool) {
    switch (cleanedTool) {
      case 'Talang':
        isCleanedTool1Checked.value = !isCleanedTool1Checked.value;
        if (isCleanedTool1Checked.value && isCleanedTool3Checked.value) {
          isCleanedTool3Checked.value = false;
        }
        break;
      case 'Mangkok':
        isCleanedTool2Checked.value = !isCleanedTool2Checked.value;
        if (isCleanedTool2Checked.value && isCleanedTool3Checked.value) {
          isCleanedTool3Checked.value = false;
        }
        break;
      case 'Bersih':
        isCleanedTool3Checked.value = !isCleanedTool3Checked.value;
        if (isCleanedTool3Checked.value) {
          // Uncheck all others if "Bersih" is checked
          isCleanedTool1Checked.value = false;
          isCleanedTool2Checked.value = false;
        }
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
