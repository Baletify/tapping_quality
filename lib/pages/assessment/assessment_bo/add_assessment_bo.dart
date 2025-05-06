import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapping_quality/controllers/assessment_bo_controller.dart';

class AddAssessmentBo extends StatelessWidget {
  const AddAssessmentBo({super.key});

  @override
  Widget build(BuildContext context) {
    final AssessmentBoController dateController = Get.put(
      AssessmentBoController(),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Asesmen',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 60,
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
                  child: _datePicker(dateController),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _datePicker(AssessmentBoController dateController) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${dateController.selectedDate.value.day}/${dateController.selectedDate.value.month}/${dateController.selectedDate.value.year}",
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const Icon(Icons.calendar_today, color: Colors.white),
          ],
        ),
      );
    });
  }
}
