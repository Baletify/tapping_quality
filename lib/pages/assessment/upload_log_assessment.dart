import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tapping_quality/controllers/upload_assessment_controller.dart';

class UploadLogAssessment extends StatelessWidget {
  const UploadLogAssessment({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadAssessmentController());
    String formatTanggalInspeksi(String? dateStr) {
      if (dateStr == null) return 'N/A';
      try {
        final date = DateTime.parse(dateStr);
        return DateFormat('d MMM y').format(date);
      } catch (e) {
        return 'N/A';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Log Upload Asesmen',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.black12,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() {
              final assessment = controller.uploadedAssessmentDetails;
              final isAllNull =
                  assessment.isNotEmpty &&
                  assessment.first.values.every((value) => value == null);
              if (isAllNull) {
                return Expanded(
                  child: Center(
                    child: Image.asset(
                      'assets/images/404-page.png',
                      width: 300,
                      height: 500,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.uploadedAssessmentDetails.length,
                  itemBuilder: (context, index) {
                    final data = controller.uploadedAssessmentDetails[index];
                    print(data);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Inspeksi Tanggal ${formatTanggalInspeksi(data['tanggal_inspeksi'])}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 2.0),

                                Text(
                                  'NIK Penyadap:  ${data['nik_penyadap'] ?? 'N/A'}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Nama Penyadap: ${data['name'] ?? 'N/A'}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Panel Sadap: ${data['panel_sadap'] ?? 'N/A'}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'No Hancak: ${data['no_hancak'] ?? 'N/A'}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Blok:  ${data['blok'] ?? 'N/A'}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Task:  ${data['task'] ?? 'N/A'}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Upload At:   ${formatTanggalInspeksi(data['tanggal_inspeksi'] ?? 'N/A')}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
