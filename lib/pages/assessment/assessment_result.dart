import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapping_quality/controllers/assessment_bo_detail_controller.dart';
import 'package:tapping_quality/controllers/assessment_bo_input_controller.dart';
import 'package:tapping_quality/controllers/assessment_ho_input_controller.dart';
import 'package:tapping_quality/controllers/assessment_result_controller.dart';
import 'package:tapping_quality/pages/home_page.dart';

class AssessmentResult extends StatefulWidget {
  final dynamic assessmentDetailId;
  final dynamic inspectionDate;
  final String? nikPenyadap;

  const AssessmentResult({
    super.key,
    required this.assessmentDetailId,
    required this.inspectionDate,
    this.nikPenyadap,
  });

  @override
  State<AssessmentResult> createState() => _AssessmentResultState();
}

final AssessmentResultController controller = Get.put(
  AssessmentResultController(),
);

class _AssessmentResultState extends State<AssessmentResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Hasil Assessment',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 700,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            height: 225,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Image.asset(
                              'assets/images/assessment_result.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'Assessment Done!',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text(
                              'Summary',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          String kelas = '';
                          double totalScore = controller.assessmentResult.fold(
                            0.0,
                            (prev, element) =>
                                prev +
                                (element['avg_score'] != null
                                    ? (element['avg_score'] as num).toDouble()
                                    : 0.0),
                          );
                          final result =
                              controller.assessmentResult.isNotEmpty
                                  ? controller.assessmentResult.first
                                  : null;
                          if (totalScore >= 0 && totalScore <= 10.9) {
                            kelas = '1';
                          } else if (totalScore > 10.9 && totalScore <= 20.9) {
                            kelas = '2';
                          } else if (totalScore > 20.9 && totalScore <= 26.9) {
                            kelas = '3';
                          } else if (totalScore > 26.9 && totalScore <= 32.9) {
                            kelas = '4';
                          } else {
                            kelas = 'No Class';
                          }
                          return Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 300,
                                  height: 400,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 6.0,
                                              left: 4.0,
                                              right: 4.0,
                                            ),
                                            child: Text(
                                              'NIK',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 6.0,
                                              left: 4.0,
                                              right: 4.0,
                                            ),
                                            child: Text(
                                              result?['nik_penyadap'] ?? 'N/A',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 6.0,
                                              left: 4.0,
                                              right: 4.0,
                                            ),
                                            child: Text(
                                              'Nama',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 6.0,
                                              left: 4.0,
                                              right: 4.0,
                                            ),
                                            child: Text(
                                              result?['name'] ?? 'N/A',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 6.0,
                                              left: 4.0,
                                              right: 4.0,
                                            ),
                                            child: Text(
                                              'Kemandoran',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 6.0,
                                              left: 4.0,
                                              right: 4.0,
                                            ),
                                            child: Text(
                                              result?['kemandoran'] ?? 'N/A',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 6.0,
                                              left: 4.0,
                                              right: 4.0,
                                            ),
                                            child: Text(
                                              'Sub Divisi',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 6.0,
                                              left: 4.0,
                                              right: 4.0,
                                            ),
                                            child: Text(
                                              result?['departemen'] ?? 'N/A',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 6.0,
                                              left: 4.0,
                                              right: 4.0,
                                            ),
                                            child: Text(
                                              'Task',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 6.0,
                                              left: 4.0,
                                              right: 4.0,
                                            ),
                                            child: Text(
                                              result?['task'] ?? 'N/A',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 6.0,
                                              left: 4.0,
                                              right: 4.0,
                                            ),
                                            child: Text(
                                              'Nilai Rata-rata',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 6.0,
                                              left: 4.0,
                                              right: 4.0,
                                            ),
                                            child: Text(
                                              totalScore != 0
                                                  ? totalScore.toStringAsFixed(
                                                    2,
                                                  )
                                                  : 'N/A',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 6.0,
                                              left: 4.0,
                                              right: 4.0,
                                            ),
                                            child: Text(
                                              'Kulit Sadap',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 6.0,
                                              left: 4.0,
                                              right: 4.0,
                                            ),
                                            child: Text(
                                              result?['jenis_kulit_pohon'] ??
                                                  'N/A',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 6.0,
                                              left: 4.0,
                                              right: 4.0,
                                            ),
                                            child: Text(
                                              'Kelas Penyadap',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 6.0,
                                              left: 4.0,
                                              right: 4.0,
                                            ),
                                            child: Text(
                                              kelas,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 6.0,
                                              left: 4.0,
                                              right: 4.0,
                                            ),
                                            child: Text(
                                              'Inspeksi Oleh',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 6.0,
                                              left: 4.0,
                                              right: 4.0,
                                            ),
                                            child: Text(
                                              result?['inspection_by'] ?? 'N/A',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 40),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.delete<
                                              AssessmentHoInputController
                                            >();
                                            Get.delete<
                                              AssessmentBoInputController
                                            >();
                                            Get.delete<
                                              AssessmentBoDetailController
                                            >();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        const HomePage(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.lightBlue[600],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            width: double.infinity,
                                            child: Center(
                                              child: Text(
                                                'Selesai',
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
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
