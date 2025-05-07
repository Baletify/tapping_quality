import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapping_quality/controllers/assessment_bo_detail_controller.dart';
import 'package:tapping_quality/models/user_model.dart';
import 'package:tapping_quality/pages/assessment/assessment_bo/input_assessment_bo.dart';

class AddAssessmentBo extends StatelessWidget {
  const AddAssessmentBo({super.key});

  @override
  Widget build(BuildContext context) {
    final AssessmentBoDetailController dateController = Get.put(
      AssessmentBoDetailController(),
    );
    final AssessmentBoDetailController userController = Get.put(
      AssessmentBoDetailController(),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Asesmen (BO)',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Tanggal Inspeksi',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                      child: Obx(() {
                        return TextButton(
                          onPressed: () async {
                            // Show the date picker dialog
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: dateController.selectedDate.value,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            // Update the selected date in the controller
                            if (pickedDate != null) {
                              dateController.updateDate(pickedDate);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${dateController.selectedDate.value.day}/${dateController.selectedDate.value.month}/${dateController.selectedDate.value.year}",
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.calendar_today,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: DropdownMenu<UserModel>(
                    width: double.infinity,
                    hintText: 'Pilih Penyadap',
                    requestFocusOnTap: true,
                    enableFilter: true,
                    dropdownMenuEntries:
                        userController.userList
                            .map(
                              (user) => DropdownMenuEntry<UserModel>(
                                label: user.name,
                                value: user,
                              ),
                            )
                            .toList(),
                    onSelected: (value) {
                      userController.updateSelectedUser(value);
                    },
                  ),
                ),
              );
            }),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: TextField(
                  controller: userController.nikController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'NIK Penyadap',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: TextField(
                  controller: userController.statusController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: TextField(
                  controller: userController.kemandoranController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Kemandoran',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: TextField(
                  controller: userController.departemenController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Kemandoran',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Blok',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Task',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'No. Hancak',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Tahun Tanam',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Clone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Sistem Sadap',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: DropdownMenu<String>(
                    controller:
                        TextEditingController(), // Optional: Add a controller if needed
                    width: double.infinity,
                    hintText: 'Panel Sadap',
                    requestFocusOnTap: true,
                    dropdownMenuEntries:
                        userController.tappingPanel
                            .map(
                              (type) => DropdownMenuEntry<String>(
                                label: type,
                                value: type,
                              ),
                            )
                            .toList(),
                    onSelected: (value) {
                      userController.updateTappingPanel(value!);
                    },
                  ),
                ),
              );
            }),
            const SizedBox(height: 15),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: DropdownMenu<String>(
                    controller:
                        TextEditingController(), // Optional: Add a controller if needed
                    width: double.infinity,
                    hintText: 'Jenis Kulit Pohon',
                    requestFocusOnTap: true,
                    dropdownMenuEntries:
                        userController.treeSkinType
                            .map(
                              (type) => DropdownMenuEntry<String>(
                                label: type,
                                value: type,
                              ),
                            )
                            .toList(),
                    onSelected: (value) {
                      userController.updateTreeSkinType(value!);
                    },
                  ),
                ),
              );
            }),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 8.0,
                right: 8.0,
                bottom: 100.0,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const InputAssessmentBo());
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[600],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'SUBMIT',
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
    );
  }
}
