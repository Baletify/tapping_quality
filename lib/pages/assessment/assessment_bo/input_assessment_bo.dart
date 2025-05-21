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
  const InputAssessmentBo({
    super.key,
    required this.assessmentDetailId,
    required this.inspectionDate,
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
  bool isQ1Answered() => controller.selectedWound.value.isNotEmpty;
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
                              'Luka Kayu - Hanya 1 Pilihan',
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
                                        'Kecil (1 cm x 0.6 cm)',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Kecil (1 cm x 0.6 cm)',
                                      groupValue:
                                          controller.selectedWound.value,
                                      onChanged: (value) {
                                        controller.selectWound(value!);
                                        checkAndAdvanceQuestion(
                                          0,
                                          isQ1Answered(),
                                        );
                                        if (value == 'Kecil (1 cm x 0.6 cm)') {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(1)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(1);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(1);
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
                                        'Sedang (1.5 cm x 3 cm)',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Sedang (1.5 cm x 3 cm)',
                                      groupValue:
                                          controller.selectedWound.value,
                                      onChanged: (value) {
                                        controller.selectWound(value!);
                                        checkAndAdvanceQuestion(
                                          0,
                                          isQ1Answered(),
                                        );
                                        if (value == 'Sedang (1.5 cm x 3 cm)') {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(2)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(2);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(2);
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
                                        'Besar (>1.5 cm x 3 cm)',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Besar (>1.5 cm x 3 cm)',
                                      groupValue:
                                          controller.selectedWound.value,
                                      onChanged: (value) {
                                        controller.selectWound(value!);
                                        checkAndAdvanceQuestion(
                                          0,
                                          isQ1Answered(),
                                        );
                                        if (value == 'Besar (>1.5 cm x 3 cm)') {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(3)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(3);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(2);
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
                                        'Tidak ada luka kayu',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: 'Tidak ada luka kayu',
                                      groupValue:
                                          controller.selectedWound.value,
                                      onChanged: (value) {
                                        controller.selectWound(value!);
                                        checkAndAdvanceQuestion(
                                          0,
                                          isQ1Answered(),
                                        );
                                        if (value == 'Tidak ada luka kayu') {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(38)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(38);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(38);
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
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(4)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(4);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(4);
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
                                        if (value == 'Normatif') {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(5)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(5);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(5);
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
                                        if (value == 'Terlalu Dalam') {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(6)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(6);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(6);
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
                                              .contains(7)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(7);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(7);
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
                                              .contains(8)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(8);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(8);
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
                                              .contains(9)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(9);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(9);
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
                                              .contains(10)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(10);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(10);
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
                                              .contains(11)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(11);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(11);
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
                                              .contains(12)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(12);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(12);
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
                                              .contains(13)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(13);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(13);
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
                                              .contains(39)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(39);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(39);
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
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(14)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(14);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(14);
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
                                        if (value == '< 30 derajat') {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(15)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(15);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(15);
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
                                        if (value == '30 derajat') {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(40)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(40);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(40);
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
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(16)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(16);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(16);
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
                                        if (value == 'Tidak Diambil') {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(17)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(17);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(17);
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
                                              .contains(18)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(18);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(18);
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
                                              .contains(19)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(19);
                                          }
                                        } else {
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
                                              .contains(20)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(20);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(20);
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
                                              .contains(41)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(41);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(41);
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
                                              .contains(21)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(21);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(21);
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
                                              .contains(22)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(22);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(22);
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
                                              .contains(41)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(41);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(41);
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
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(23)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(23);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(23);
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
                                        if (value == 'Kotor') {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(24)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(24);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(24);
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
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(25)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(25);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(25);
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
                                        if (value == 'Tidak') {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(26)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(26);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(26);
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
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(27)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(27);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(27);
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
                                        if (value == 'Tidak') {
                                          if (!controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .contains(28)) {
                                            controller
                                                .selectedCriteriaIds[treeIndex -
                                                    1]
                                                .add(28);
                                          }
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(28);
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
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .add(29);
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(29);
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
                                        if (value == 'Tidak') {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .add(30);
                                        } else {
                                          controller
                                              .selectedCriteriaIds[treeIndex -
                                                  1]
                                              .remove(30);
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
                      final inspectionDate = detail?['tanggal_inspeksi'];

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
                          inspectionDate: inspectionDate,
                        ),
                      );
                      print('All Tree Index ${controller.selectedCriteriaIds}');
                      resultService.fetchAssessmentResult(
                        assessmentDetailId,
                        inspectionDate,
                      );
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
      height: 110,
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
                  'Sistem Sadap:',
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
                    detail?['sistem_sadap'] ?? 'N/A',
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
        ],
      ),
    );
  }

  Container _leftCard(detail) {
    return Container(
      width: 180,
      height: 110,
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
