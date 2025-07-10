import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapping_quality/controllers/assessment_bo_input_controller.dart';
import 'package:tapping_quality/controllers/assessment_result_controller.dart';
import 'package:tapping_quality/pages/assessment/assessment_result.dart';
import 'package:intl/intl.dart';
import 'package:tapping_quality/services/assessment_input_bo_service.dart';

class InputAssessmentBo extends StatefulWidget {
  final int assessmentDetailId;
  final dynamic inspectionDate;
  final String? nikPenyadap;
  const InputAssessmentBo({
    super.key,
    required this.assessmentDetailId,
    required this.inspectionDate,
    required this.nikPenyadap,
  });

  @override
  State<InputAssessmentBo> createState() => _InputAssessmentBoState();
}

class _InputAssessmentBoState extends State<InputAssessmentBo> {
  final AssessmentBoInputController controller = Get.put(
    AssessmentBoInputController(),
  );
  final ScrollController _scrollController = ScrollController();

  int treeIndex = 1; // Start with Tree 1
  int questionIndex = 0; // Start with Question 1
  final service = Get.put(AssessmentInputBoService());
  final resultService = Get.put(AssessmentResultController());

  String formatTanggalInspeksi(String? dateStr) {
    if (dateStr == null) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('d MMMM y').format(date);
    } catch (e) {
      return 'N/A';
    }
  }

  void incrementTreeIndex() {
    if (treeIndex < 10) {
      setState(() {
        treeIndex++;
        if (controller.selectedCriteriaIds.length < treeIndex) {
          controller.selectedCriteriaIds.add([]);
        }
      });
      resetQuestionCount();
      controller.resetState(); // Reset the state for the new tree
      _scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      Get.snackbar(
        'Info',
        'You have reached the last tree.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    }
  }

  void decrementTreeIndex() {
    if (treeIndex > 1) {
      setState(() {
        // Remove the last criteria list (for the current tree)
        if (controller.selectedCriteriaIds.length >= treeIndex) {
          controller.selectedCriteriaIds.removeAt(treeIndex - 1);
        }
        treeIndex--;
        // Re-initialize the criteria list for the previous tree as empty
        if (controller.selectedCriteriaIds.length < treeIndex) {
          controller.selectedCriteriaIds.add([]);
        } else {
          controller.selectedCriteriaIds[treeIndex - 1] = [];
        }

        // controller.resetState();
        resetQuestionCount();
        controller.resetState(); // Reset the state for the new tree
        _scrollController.animateTo(
          0.0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    } else {
      Get.snackbar(
        'Info',
        'You are already at the first tree.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    }
  }

  List<bool> answeredQuestions = List.generate(11, (index) => false);
  bool isQ1Answered() =>
      controller.isWound1Checked.value ||
      controller.isWound2Checked.value ||
      controller.isWound3Checked.value ||
      controller.isWound4Checked.value;
  bool isQ2Answered() => controller.selectedDepth.value.isNotEmpty;
  bool isQ3Answered() =>
      controller.isOpt1Checked.value ||
      controller.isOpt2Checked.value ||
      controller.isOpt3Checked.value ||
      controller.isOpt4Checked.value ||
      controller.isOpt5Checked.value ||
      controller.isOpt6Checked.value ||
      controller.isOpt7Checked.value ||
      controller.isOpt8Checked.value;
  bool isQ4Answered() => controller.selectedAngle.value.isNotEmpty;
  bool isQ5Answered() => controller.selectedScrap.value.isNotEmpty;
  bool isQ6Answered() =>
      controller.isTool1Checked.value ||
      controller.isTool2Checked.value ||
      controller.isTool3Checked.value ||
      controller.isTool4Checked.value;
  bool isQ7Answered() =>
      controller.isCleanedTool1Checked.value ||
      controller.isCleanedTool2Checked.value ||
      controller.isCleanedTool3Checked.value;
  bool isQ8Answered() => controller.selectedBlong.value.isNotEmpty;
  bool isQ9Answered() => controller.selectedHealthyTree.value.isNotEmpty;
  bool isQ10Answered() => controller.selectedResultTake.value.isNotEmpty;
  bool isQ11Answered() => controller.selectedTalangSadap.value.isNotEmpty;

  void checkAndAdvanceQuestion(int containerIndex, bool isNowAnswered) {
    if (isNowAnswered && !answeredQuestions[containerIndex]) {
      setState(() {
        answeredQuestions[containerIndex] = true;
        questionIndex++;
      });
    } else if (!isNowAnswered && answeredQuestions[containerIndex]) {
      setState(() {
        answeredQuestions[containerIndex] = false;
        questionIndex--;
      });
    }
  }

  void resetQuestionCount() {
    setState(() {
      questionIndex = 0;
      answeredQuestions = List.generate(11, (index) => false);
    });
  }

  void selectDepthRadioBtn(int treeIndex, int selectedId) {
    final depthID = [9, 10, 11]; // all possible IDs for this question
    controller.selectedCriteriaIds[treeIndex - 1].removeWhere(
      (id) => depthID.contains(id),
    );
    controller.selectedCriteriaIds[treeIndex - 1].add(selectedId);
  }

  selectAngleRadioBtn(int treeIndex, int selectedId) {
    final angleID = [20, 21, 22]; // all possible IDs for this question
    controller.selectedCriteriaIds[treeIndex - 1].removeWhere(
      (id) => angleID.contains(id),
    );
    controller.selectedCriteriaIds[treeIndex - 1].add(selectedId);
  }

  selectScrapRadioBtn(int treeIndex, int selectedId) {
    final scrapID = [26, 27]; // all possible IDs for this question
    controller.selectedCriteriaIds[treeIndex - 1].removeWhere(
      (id) => scrapID.contains(id),
    );
    controller.selectedCriteriaIds[treeIndex - 1].add(selectedId);
  }

  void selectBlongRadioBtn(int treeIndex, int selectedId) {
    final blongID = [35, 36]; // all possible IDs for this question
    controller.selectedCriteriaIds[treeIndex - 1].removeWhere(
      (id) => blongID.contains(id),
    );
    controller.selectedCriteriaIds[treeIndex - 1].add(selectedId);
  }

  void selectHealthyTreeRadioBtn(int treeIndex, int selectedId) {
    final healthyTreeID = [37, 38]; // all possible IDs for this question
    controller.selectedCriteriaIds[treeIndex - 1].removeWhere(
      (id) => healthyTreeID.contains(id),
    );
    controller.selectedCriteriaIds[treeIndex - 1].add(selectedId);
  }

  void selectResultTakeRadioBtn(int treeIndex, int selectedId) {
    final resultTakeID = [39, 40]; // all possible IDs for this question
    controller.selectedCriteriaIds[treeIndex - 1].removeWhere(
      (id) => resultTakeID.contains(id),
    );
    controller.selectedCriteriaIds[treeIndex - 1].add(selectedId);
  }

  void selectTalangSadapRadioBtn(int treeIndex, int selectedId) {
    final talangSadapID = [41, 42]; // all possible IDs for this question
    controller.selectedCriteriaIds[treeIndex - 1].removeWhere(
      (id) => talangSadapID.contains(id),
    );
    controller.selectedCriteriaIds[treeIndex - 1].add(selectedId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Input Assessment (BO)',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Obx(() {
              final detail =
                  controller.assessmentDetails.isNotEmpty
                      ? controller.assessmentDetails.first
                      : null;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_leftCard(detail), _rightCard(detail)],
              );
            }),
          ),
          const SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 350,
                height: 10,
                decoration: BoxDecoration(color: Colors.white),
                child: LinearProgressIndicator(
                  value: treeIndex / 10,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Jumlah Pohon yang Diinspeksi',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Pohon $treeIndex dari 10',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: 350,
                height: 10,
                decoration: BoxDecoration(color: Colors.white),
                child: LinearProgressIndicator(
                  value: questionIndex / 11,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress Jumlah Item yang Dinilai',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Penilaian $questionIndex dari 11',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // 1 Luka Kayu
                    Container(
                      height: 300,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 8.0,
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: Text(
                              'Luka Kayu - Bisa Pilih Lebih dari 1',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 2.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Kecil (1cm x0.6cm)',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isWound1Checked.value,
                                      onChanged: (value) {
                                        controller.toggleWoundCheckbox('Kecil');
                                        checkAndAdvanceQuestion(
                                          0,
                                          isQ1Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(1)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(1);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(4);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(1);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(4);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Sedang (1.5cm x 3cm)',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isWound2Checked.value,
                                      onChanged: (value) {
                                        controller.toggleWoundCheckbox(
                                          'Sedang',
                                        );
                                        checkAndAdvanceQuestion(
                                          0,
                                          isQ1Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(2)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(2);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(4);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(2);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(4);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Besar(>1.5cm x 3cm)',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isWound3Checked.value,
                                      onChanged: (value) {
                                        controller.toggleWoundCheckbox('Besar');
                                        checkAndAdvanceQuestion(
                                          0,
                                          isQ1Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(3)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(3);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(4);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(3);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(4);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Tidak Ada Luka Kayu',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isWound4Checked.value,
                                      onChanged: (value) {
                                        controller.toggleWoundCheckbox('OK');
                                        checkAndAdvanceQuestion(
                                          0,
                                          isQ1Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(4)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(4);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(1);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(2);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(3);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(1);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(2);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(3);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(4);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // 2 Kedalaman Sadap
                    Container(
                      height: 250,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 8.0,
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: Text(
                              'Kedalaman Sadap - Hanya 1 Pilihan',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 2.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => RadioListTile<String>(
                                      title: const Text(
                                        'Kurang Dalam',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Kurang Dalam',
                                      groupValue:
                                          controller.selectedDepth.value,
                                      onChanged: (value) {
                                        controller.selectDepth(value!);
                                        checkAndAdvanceQuestion(
                                          1,
                                          isQ2Answered(),
                                        );
                                        if (value == 'Kurang Dalam') {
                                          selectDepthRadioBtn(treeIndex, 9);
                                        } else if (value == 'Normatif') {
                                          selectDepthRadioBtn(treeIndex, 10);
                                        } else if (value == 'Terlalu Dalam') {
                                          selectDepthRadioBtn(treeIndex, 11);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => RadioListTile<String>(
                                      title: const Text(
                                        'Normatif',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Normatif',
                                      groupValue:
                                          controller.selectedDepth.value,
                                      onChanged: (value) {
                                        controller.selectDepth(value!);
                                        checkAndAdvanceQuestion(
                                          1,
                                          isQ2Answered(),
                                        );
                                        if (value == 'Kurang Dalam') {
                                          selectDepthRadioBtn(treeIndex, 9);
                                        } else if (value == 'Normatif') {
                                          selectDepthRadioBtn(treeIndex, 10);
                                        } else if (value == 'Terlalu Dalam') {
                                          selectDepthRadioBtn(treeIndex, 11);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => RadioListTile<String>(
                                      title: const Text(
                                        'Terlalu Dalam',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Terlalu Dalam',
                                      groupValue:
                                          controller.selectedDepth.value,
                                      onChanged: (value) {
                                        controller.selectDepth(value!);
                                        checkAndAdvanceQuestion(
                                          1,
                                          isQ2Answered(),
                                        );
                                        if (value == 'Kurang Dalam') {
                                          selectDepthRadioBtn(treeIndex, 9);
                                        } else if (value == 'Normatif') {
                                          selectDepthRadioBtn(treeIndex, 10);
                                        } else if (value == 'Terlalu Dalam') {
                                          selectDepthRadioBtn(treeIndex, 11);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // 3 Irisan Sadap
                    Container(
                      height: 550,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 8.0,
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: Text(
                              'Irisan Sadap - Bisa Pilih Lebih dari 1',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 2.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Irisan melampaui batas depan',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isOpt1Checked.value,
                                      onChanged: (value) {
                                        controller.toggleCheckbox2('opt1');
                                        checkAndAdvanceQuestion(
                                          2,
                                          isQ3Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(12)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(12);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(19);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(12);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(19);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Irisan melampaui batas belakang',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isOpt2Checked.value,
                                      onChanged: (value) {
                                        controller.toggleCheckbox2('opt2');
                                        checkAndAdvanceQuestion(
                                          2,
                                          isQ3Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(13)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(13);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(19);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(13);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(19);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Tidak ada sodokan',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isOpt3Checked.value,
                                      onChanged: (value) {
                                        controller.toggleCheckbox2('opt3');
                                        checkAndAdvanceQuestion(
                                          2,
                                          isQ3Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(14)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(14);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(19);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(14);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(19);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Tidak ada pethikan (V)',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isOpt4Checked.value,
                                      onChanged: (value) {
                                        controller.toggleCheckbox2('opt4');
                                        checkAndAdvanceQuestion(
                                          2,
                                          isQ3Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(15)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(15);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(19);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(15);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(19);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Tebal tatal > 2mm',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isOpt5Checked.value,
                                      onChanged: (value) {
                                        controller.toggleCheckbox2('opt5');
                                        checkAndAdvanceQuestion(
                                          2,
                                          isQ3Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(16)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(16);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(19);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(16);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(19);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Bergelombang',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isOpt6Checked.value,
                                      onChanged: (value) {
                                        controller.toggleCheckbox2('opt6');
                                        checkAndAdvanceQuestion(
                                          2,
                                          isQ3Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(17)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(17);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(19);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(17);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(19);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Tidak ada Tanda Bulan',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isOpt7Checked.value,
                                      onChanged: (value) {
                                        controller.toggleCheckbox2('opt7');
                                        checkAndAdvanceQuestion(
                                          2,
                                          isQ3Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(18)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(18);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(19);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(18);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(19);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Irisan sadap sudah sesuai',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isOpt8Checked.value,
                                      onChanged: (value) {
                                        controller.toggleCheckbox2('opt8');
                                        checkAndAdvanceQuestion(
                                          2,
                                          isQ3Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(19)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(19);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(12);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(13);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(14);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(15);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(16);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(17);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(18);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(12);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(13);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(14);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(15);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(16);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(17);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(18);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(19);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // 4 Sudut Sadap
                    Container(
                      height: 240,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 8.0,
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: Text(
                              'Sudut Sadap - Hanya 1 Pilihan',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 2.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => RadioListTile<String>(
                                      title: const Text(
                                        '> 30 derajat',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: '> 30 derajat',
                                      groupValue:
                                          controller.selectedAngle.value,
                                      onChanged: (value) {
                                        controller.selectAngle(value!);
                                        checkAndAdvanceQuestion(
                                          3,
                                          isQ4Answered(),
                                        );
                                        if (value == '> 30 derajat') {
                                          selectAngleRadioBtn(treeIndex, 20);
                                        } else if (value == '< 30 derajat') {
                                          selectAngleRadioBtn(treeIndex, 21);
                                        } else if (value == '30 derajat') {
                                          selectAngleRadioBtn(treeIndex, 22);
                                        }
                                      },

                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => RadioListTile<String>(
                                      title: const Text(
                                        '< 30 derajat',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: '< 30 derajat',
                                      groupValue:
                                          controller.selectedAngle.value,
                                      onChanged: (value) {
                                        controller.selectAngle(value!);
                                        checkAndAdvanceQuestion(
                                          3,
                                          isQ4Answered(),
                                        );
                                        if (value == '> 30 derajat') {
                                          selectAngleRadioBtn(treeIndex, 20);
                                        } else if (value == '< 30 derajat') {
                                          selectAngleRadioBtn(treeIndex, 21);
                                        } else if (value == '30 derajat') {
                                          selectAngleRadioBtn(treeIndex, 22);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => RadioListTile<String>(
                                      title: const Text(
                                        '30 derajat',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: '30 derajat',
                                      groupValue:
                                          controller.selectedAngle.value,
                                      onChanged: (value) {
                                        controller.selectAngle(value!);
                                        checkAndAdvanceQuestion(
                                          3,
                                          isQ4Answered(),
                                        );
                                        if (value == '> 30 derajat') {
                                          selectAngleRadioBtn(treeIndex, 20);
                                        } else if (value == '< 30 derajat') {
                                          selectAngleRadioBtn(treeIndex, 21);
                                        } else if (value == '30 derajat') {
                                          selectAngleRadioBtn(treeIndex, 22);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // 5 Pengambilan Scrap
                    Container(
                      height: 180,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 8.0,
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: Text(
                              'Pengambilan Scrap - Hanya 1 Pilihan',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 2.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => RadioListTile<String>(
                                      title: const Text(
                                        'Diambil',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Diambil',
                                      groupValue:
                                          controller.selectedScrap.value,
                                      onChanged: (value) {
                                        controller.selectScrap(value!);
                                        checkAndAdvanceQuestion(
                                          4,
                                          isQ5Answered(),
                                        );
                                        if (value == 'Diambil') {
                                          selectScrapRadioBtn(treeIndex, 26);
                                        } else if (value == 'Tidak Diambil') {
                                          selectScrapRadioBtn(treeIndex, 27);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => RadioListTile<String>(
                                      title: const Text(
                                        'Tidak Diambil',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Tidak Diambil',
                                      groupValue:
                                          controller.selectedScrap.value,
                                      onChanged: (value) {
                                        controller.selectScrap(value!);
                                        checkAndAdvanceQuestion(
                                          4,
                                          isQ5Answered(),
                                        );
                                        if (value == 'Diambil') {
                                          selectScrapRadioBtn(treeIndex, 26);
                                        } else if (value == 'Tidak Diambil') {
                                          selectScrapRadioBtn(treeIndex, 27);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // 6 Peralatan tidak lengkap
                    Container(
                      height: 320,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 8.0,
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: Text(
                              'Peralatan tidak lengkap - Bisa Pilih Lebih dari 1',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 2.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Talang',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isTool1Checked.value,
                                      onChanged: (value) {
                                        controller.toggleCheckbox3('Talang');
                                        checkAndAdvanceQuestion(
                                          5,
                                          isQ6Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(28)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(28);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(31);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(28);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(31);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Mangkok',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isTool2Checked.value,
                                      onChanged: (value) {
                                        controller.toggleCheckbox3('Mangkok');
                                        checkAndAdvanceQuestion(
                                          5,
                                          isQ6Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(29)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(29);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(31);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(29);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(31);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Hanger',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isTool3Checked.value,
                                      onChanged: (value) {
                                        controller.toggleCheckbox3('Hanger');
                                        checkAndAdvanceQuestion(
                                          5,
                                          isQ6Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(30)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(30);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(31);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(30);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(31);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Peralatan Lengkap',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isTool4Checked.value,
                                      onChanged: (value) {
                                        controller.toggleCheckbox3('Lengkap');
                                        checkAndAdvanceQuestion(
                                          5,
                                          isQ6Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(31)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(31);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(28);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(29);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(30);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(28);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(29);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(30);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(31);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // 7 Kebersihan Alat
                    Container(
                      height: 240,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 8.0,
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: Text(
                              'Kebersihan Alat - Bisa Pilih Lebih dari 1',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 2.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Talang Kotor',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value:
                                          controller
                                              .isCleanedTool1Checked
                                              .value,
                                      onChanged: (value) {
                                        controller.toggleCheckbox4('Talang');
                                        checkAndAdvanceQuestion(
                                          6,
                                          isQ7Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(32)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(32);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(34);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(32);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(34);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Mangkok Kotor',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value:
                                          controller
                                              .isCleanedTool2Checked
                                              .value,
                                      onChanged: (value) {
                                        controller.toggleCheckbox4('Mangkok');
                                        checkAndAdvanceQuestion(
                                          6,
                                          isQ7Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(33)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(33);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(34);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(33);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(34);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => CheckboxListTile(
                                      title: const Text(
                                        'Peralatan Bersih',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value:
                                          controller
                                              .isCleanedTool3Checked
                                              .value,
                                      onChanged: (value) {
                                        controller.toggleCheckbox4('Bersih');
                                        checkAndAdvanceQuestion(
                                          6,
                                          isQ7Answered(),
                                        );
                                        if (value == true) {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(34)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(34);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(32);
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .remove(33);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(32);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(33);
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(34);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // 8 Kebersihan Ember/Blong latek
                    Container(
                      height: 200,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 8.0,
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: Text(
                              'Kebersihan Ember/Blong latek - Hanya 1 Pilihan',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 2.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => RadioListTile<String>(
                                      title: const Text(
                                        'Bersih',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Bersih',
                                      groupValue:
                                          controller.selectedBlong.value,
                                      onChanged: (value) {
                                        controller.selectBlong(value!);
                                        checkAndAdvanceQuestion(
                                          7,
                                          isQ8Answered(),
                                        );
                                        if (value == 'Bersih') {
                                          selectBlongRadioBtn(treeIndex, 35);
                                        } else if (value == 'Kotor') {
                                          selectBlongRadioBtn(treeIndex, 36);
                                        }
                                      },

                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => RadioListTile<String>(
                                      title: const Text(
                                        'Kotor',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Kotor',
                                      groupValue:
                                          controller.selectedBlong.value,
                                      onChanged: (value) {
                                        controller.selectBlong(value!);
                                        checkAndAdvanceQuestion(
                                          7,
                                          isQ8Answered(),
                                        );
                                        if (value == 'Bersih') {
                                          selectBlongRadioBtn(treeIndex, 35);
                                        } else if (value == 'Kotor') {
                                          selectBlongRadioBtn(treeIndex, 36);
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // 9 Pohon sehat tidak disadap
                    Container(
                      height: 180,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 8.0,
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: Text(
                              'Pohon sehat tidak disadap - Hanya 1 Pilihan',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 2.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => RadioListTile<String>(
                                      title: const Text(
                                        'Ya',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Ya',
                                      groupValue:
                                          controller.selectedHealthyTree.value,
                                      onChanged: (value) {
                                        controller.selectHealthyTree(value!);
                                        checkAndAdvanceQuestion(
                                          8,
                                          isQ9Answered(),
                                        );
                                        if (value == 'Ya') {
                                          selectHealthyTreeRadioBtn(
                                            treeIndex,
                                            37,
                                          );
                                        } else if (value == 'Tidak') {
                                          selectHealthyTreeRadioBtn(
                                            treeIndex,
                                            38,
                                          );
                                        }
                                      },

                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => RadioListTile<String>(
                                      title: const Text(
                                        'Tidak',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Tidak',
                                      groupValue:
                                          controller.selectedHealthyTree.value,
                                      onChanged: (value) {
                                        controller.selectHealthyTree(value!);
                                        checkAndAdvanceQuestion(
                                          8,
                                          isQ9Answered(),
                                        );
                                        if (value == 'Ya') {
                                          selectHealthyTreeRadioBtn(
                                            treeIndex,
                                            37,
                                          );
                                        } else if (value == 'Tidak') {
                                          selectHealthyTreeRadioBtn(
                                            treeIndex,
                                            38,
                                          );
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // 10 Hasil tidak dipungut
                    Container(
                      height: 180,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 8.0,
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: Text(
                              'Hasil tidak dipungut - Hanya 1 Pilihan',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 2.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => RadioListTile<String>(
                                      title: const Text(
                                        'Ya',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Ya',
                                      groupValue:
                                          controller.selectedResultTake.value,
                                      onChanged: (value) {
                                        controller.selectResultTake(value!);
                                        checkAndAdvanceQuestion(
                                          9,
                                          isQ10Answered(),
                                        );
                                        if (value == 'Ya') {
                                          selectResultTakeRadioBtn(
                                            treeIndex,
                                            39,
                                          );
                                        } else if (value == 'Tidak') {
                                          selectResultTakeRadioBtn(
                                            treeIndex,
                                            40,
                                          );
                                        }
                                      },

                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => RadioListTile<String>(
                                      title: const Text(
                                        'Tidak',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Tidak',
                                      groupValue:
                                          controller.selectedResultTake.value,
                                      onChanged: (value) {
                                        controller.selectResultTake(value!);
                                        checkAndAdvanceQuestion(
                                          9,
                                          isQ10Answered(),
                                        );
                                        if (value == 'Ya') {
                                          selectResultTakeRadioBtn(
                                            treeIndex,
                                            39,
                                          );
                                        } else if (value == 'Tidak') {
                                          selectResultTakeRadioBtn(
                                            treeIndex,
                                            40,
                                          );
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // 11 Talang sadap mepet
                    Container(
                      height: 180,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 8.0,
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: Text(
                              'Talang sadap mepet - Hanya 1 Pilihan',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              top: 2.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => RadioListTile<String>(
                                      title: const Text(
                                        'Ya',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Ya',
                                      groupValue:
                                          controller.selectedTalangSadap.value,
                                      onChanged: (value) {
                                        controller.selectTalangSadap(value!);
                                        checkAndAdvanceQuestion(
                                          10,
                                          isQ11Answered(),
                                        );
                                        if (value == 'Ya') {
                                          selectTalangSadapRadioBtn(
                                            treeIndex,
                                            41,
                                          );
                                        } else if (value == 'Tidak') {
                                          selectTalangSadapRadioBtn(
                                            treeIndex,
                                            42,
                                          );
                                        }
                                      },

                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                    () => RadioListTile<String>(
                                      title: const Text(
                                        'Tidak',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Tidak',
                                      groupValue:
                                          controller.selectedTalangSadap.value,
                                      onChanged: (value) {
                                        controller.selectTalangSadap(value!);
                                        checkAndAdvanceQuestion(
                                          10,
                                          isQ11Answered(),
                                        );
                                        if (value == 'Ya') {
                                          selectTalangSadapRadioBtn(
                                            treeIndex,
                                            41,
                                          );
                                        } else if (value == 'Tidak') {
                                          selectTalangSadapRadioBtn(
                                            treeIndex,
                                            42,
                                          );
                                        }
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0, left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: decrementTreeIndex,
                  child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[600],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Sebelumnya',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (treeIndex == 10) {
                      final detail =
                          controller.assessmentDetails.isNotEmpty
                              ? controller.assessmentDetails.first
                              : null;
                      final assessmentDetailId = detail?['id'];
                      final nikPenyadap = detail?['nik_penyadap'];
                      final inspectionDate = detail?['tanggal_inspeksi'];
                      String dateString;
                      if (inspectionDate is DateTime) {
                        dateString =
                            "${inspectionDate.year.toString().padLeft(4, '0')}-${inspectionDate.month.toString().padLeft(2, '0')}-${inspectionDate.day.toString().padLeft(2, '0')}";
                      } else if (inspectionDate is String &&
                          inspectionDate.length >= 10) {
                        // Take only the first 10 characters (yyyy-MM-dd)
                        dateString = inspectionDate.substring(0, 10);
                      } else {
                        dateString = inspectionDate.toString();
                      }
                      List<Map<String, dynamic>> toSave = [];
                      for (
                        int treeIdx = 0;
                        treeIdx < controller.selectedCriteriaIds.length;
                        treeIdx++
                      ) {
                        final treeId =
                            treeIdx + 1; // If your tree_id starts from 1
                        for (final criteriaId
                            in controller.selectedCriteriaIds[treeIdx]) {
                          toSave.add({
                            'tree_id': treeId,
                            'criteria_id': criteriaId,
                            'assessment_detail_id': assessmentDetailId,
                          });
                        }
                      }
                      await service.insertAssessment(toSave);
                      Get.to(
                        () => AssessmentResult(
                          assessmentDetailId: assessmentDetailId,
                          inspectionDate: dateString,
                          nikPenyadap: detail?['nik_penyadap'],
                        ),
                      );
                      print('All Tree Index ${controller.selectedCriteriaIds}');
                      resultService.fetchAssessmentResult(
                        nikPenyadap,
                        dateString,
                      );
                      print('date string: $dateString');
                    } else {
                      print(
                        'Selected Criteria for Tree $treeIndex: ${controller.selectedCriteriaIds[treeIndex - 1]}',
                      );
                      print('Tree Index: $treeIndex');
                      incrementTreeIndex();
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[600],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        treeIndex == 10 ? 'Submit' : 'Berikutnya',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _rightCard(detail) {
    return Container(
      width: 180,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 5.0),
            child: const Text(
              'Detail Assessment:',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                child: const Text(
                  'Tanggal:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Text(
                    formatTanggalInspeksi(detail?['tanggal_inspeksi']),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                child: const Text(
                  'Panel Sadap:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Text(
                    detail?['panel_sadap'] ?? 'N/A',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                child: const Text(
                  'Task:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Text(
                    detail?['task'] ?? 'N/A',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                child: const Text(
                  'Kulit Sadap:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Text(
                    detail?['jenis_kulit_pohon'] ?? 'N/A',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                child: const Text(
                  'Blok:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Text(
                    detail?['blok'] ?? 'N/A',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                child: const Text(
                  'Clone:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Text(
                    detail?['clone'] ?? 'N/A',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _leftCard(detail) {
    return Container(
      width: 180,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 5.0),
            child: const Text(
              'Detail Tapper:',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                child: const Text(
                  'NIK:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Text(
                    detail?['nik_penyadap'] ?? 'N/A',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                child: const Text(
                  'Nama:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Text(
                    detail?['name'] ?? 'N/A',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                child: const Text(
                  'Kemandoran:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Text(
                    detail?['kemandoran'] ?? 'N/A',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                child: const Text(
                  'Sub Divisi:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Text(
                    detail?['departemen'] ?? 'N/A',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
