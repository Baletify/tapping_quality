import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:tapping_quality/controllers/assessment_result_controller.dart';
import 'package:tapping_quality/controllers/inspection_log_controller.dart';
import 'package:tapping_quality/models/user_model.dart';

class InspectionLog extends StatelessWidget {
  const InspectionLog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InspectionLogController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Assessment Log',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: Container(
                            height: 58,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Obx(() {
                              return TextButton(
                                onPressed: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: controller.selectedDate.value,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );

                                  if (pickedDate != null) {
                                    controller.updateDate(pickedDate);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year}",
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
                      Expanded(
                        child: Obx(() {
                          return Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(color: Colors.white),
                              child: DropdownMenu<UserModel>(
                                width: double.infinity,
                                hintText: 'Pilih Penyadap',
                                requestFocusOnTap: true,
                                enableFilter: true,
                                dropdownMenuEntries:
                                    controller.userList
                                        .map(
                                          (user) =>
                                              DropdownMenuEntry<UserModel>(
                                                label: user.name,
                                                value: user,
                                              ),
                                        )
                                        .toList(),
                                onSelected: (value) {
                                  controller.updateSelectedUser(value);
                                },
                              ),
                            ),
                          );
                        }),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final selectedUserNik =
                              controller.selectedUser.value?.nik ?? '';
                          final date = controller.selectedDate.value;
                          final dateString =
                              "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                          controller.fetchAssessmentReport(
                            selectedUserNik,
                            dateString,
                          );
                          // print(dateString);
                          // print(selectedUserNik);
                          controller.isSearched.value = true;
                        },

                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(20, 55),
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Icon(Icons.search, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent,
                ),
                child: Obx(() {
                  final report = controller.assessmentReport;
                  final isAllNull =
                      report.isNotEmpty &&
                      report.first.values.every((value) => value == null);
                  if (!controller.isSearched.value ||
                      report.isEmpty ||
                      isAllNull) {
                    return Center(
                      child: Image.asset(
                        'assets/images/404-page.png',
                        width: 200,
                        height: 200,
                      ),
                    );
                  } else {
                    // Show your Card/ListView with results
                    return ListView.builder(
                      itemCount: controller.assessmentReport.length,
                      itemBuilder: (context, index) {
                        final result = controller.assessmentReport[index];
                        return Card(
                          child: ListTile(
                            title: Text(result['name'] ?? 'N/A'),
                            subtitle: Text(result['nik_penyadap'] ?? 'N/A'),
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
