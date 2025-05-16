import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapping_quality/controllers/assessment_bo_input_controller.dart';
import 'package:tapping_quality/pages/assessment/assessment_result.dart';

class InputAssessmentBo extends StatefulWidget {
  const InputAssessmentBo({super.key});

  @override
  State<InputAssessmentBo> createState() => _InputAssessmentBoState();
}

class _InputAssessmentBoState extends State<InputAssessmentBo> {
  final AssessmentBoInputController controller = Get.put(
    AssessmentBoInputController(),
  );

  int treeIndex = 1; // Start with Tree 1
  int questionIndex = 0; // Start with Question 1

  void incrementTreeIndex() {
    if (treeIndex < 10) {
      setState(() {
        treeIndex++;
      });
      resetQuestionCount();
      controller.resetState(); // Reset the state for the new tree
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
        treeIndex--;
        resetQuestionCount();
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
      controller.isSmallChecked.value ||
      controller.isMediumChecked.value ||
      controller.isLargeChecked.value;
  bool isQ2Answered() => controller.selectedDepth.value.isNotEmpty;
  bool isQ3Answered() =>
      controller.isOpt1Checked.value ||
      controller.isOpt2Checked.value ||
      controller.isOpt3Checked.value ||
      controller.isOpt4Checked.value ||
      controller.isOpt5Checked.value ||
      controller.isOpt6Checked.value ||
      controller.isOpt7Checked.value;
  bool isQ4Answered() => controller.selectedAngle.value.isNotEmpty;
  bool isQ5Answered() => controller.selectedScrap.value.isNotEmpty;
  bool isQ6Answered() =>
      controller.isTool1Checked.value ||
      controller.isTool2Checked.value ||
      controller.isTool3Checked.value;
  bool isQ7Answered() =>
      controller.isCleanedTool1Checked.value ||
      controller.isCleanedTool2Checked.value;
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
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // 1 Luka Kayu
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
                                        'Kecil (1 cm x 0.6 cm)',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isSmallChecked.value,
                                      onChanged: (value) {
                                        controller.toggleCheckbox('small');
                                        checkAndAdvanceQuestion(
                                          0,
                                          isQ1Answered(),
                                        );
                                        if (value == true) {
                                          controller.selectedCriteriaIds.add(1);
                                        } else {
                                          controller.selectedCriteriaIds.remove(
                                            1,
                                          );
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
                                        'Sedang (1.5 cm x 3 cm)',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isMediumChecked.value,
                                      onChanged: (value) {
                                        controller.toggleCheckbox('medium');
                                        checkAndAdvanceQuestion(
                                          0,
                                          isQ1Answered(),
                                        );
                                        if (value == true) {
                                          controller.selectedCriteriaIds.add(2);
                                        } else {
                                          controller.selectedCriteriaIds.remove(
                                            2,
                                          );
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
                                        'Besar (>1.5 cm x 3 cm)',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: controller.isLargeChecked.value,
                                      onChanged: (value) {
                                        controller.toggleCheckbox('large');
                                        checkAndAdvanceQuestion(
                                          0,
                                          isQ1Answered(),
                                        );
                                        if (value == true) {
                                          controller.selectedCriteriaIds.add(3);
                                        } else {
                                          controller.selectedCriteriaIds.remove(
                                            3,
                                          );
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
                      height: 500,
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
                                        'Talang',
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
                                          controller.selectedBlong.value,
                                      onChanged: (value) {
                                        controller.selectBlong(value!);
                                        checkAndAdvanceQuestion(
                                          7,
                                          isQ8Answered(),
                                        );
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
                                          controller.selectedBlong.value,
                                      onChanged: (value) {
                                        controller.selectBlong(value!);
                                        checkAndAdvanceQuestion(
                                          7,
                                          isQ8Answered(),
                                        );
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
                  onTap: () {
                    if (treeIndex == 10) {
                      Get.to(() => AssessmentResult());
                    } else {
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
                    detail?['tanggal_inspeksi'] ?? 'N/A',
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
