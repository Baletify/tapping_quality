import 'package:flutter/material.dart';
import 'package:tapping_quality/models/tapper_model.dart';
import 'package:tapping_quality/pages/assessment/assessment_bo/input_assesment_bo.dart';

class AddAssessmentBo extends StatefulWidget {
  const AddAssessmentBo({super.key});

  @override
  State<AddAssessmentBo> createState() => _AddAssessmentBoState();
}

class _AddAssessmentBoState extends State<AddAssessmentBo> {
  final TextEditingController _getTapperController = TextEditingController();
  final TextEditingController _getNikController = TextEditingController();
  final TextEditingController _getKemandoranController =
      TextEditingController();
  final TextEditingController _getSubDivisiController = TextEditingController();
  final TextEditingController _getTappingSystemController =
      TextEditingController();
  final TextEditingController _getTaskController = TextEditingController();
  final TextEditingController _getCategoryController = TextEditingController();

  TapperModel? selectedTapper;
  String? selectedNik;
  String? selectedKemandoran;
  String? selectedSubDivisi;
  String? selectedTappingSystem;
  String? selectedTask;
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    var dates = <DateTime?>[];
    dates.add(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Asesmen Sadap Bawah',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _topBarMethod(),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 8.0,
                right: 8.0,
                bottom: 4.0,
              ),
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: const Text(
                        'Tanggal',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _dateMethod(context, dates),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 8.0,
                right: 8.0,
                bottom: 4.0,
              ),
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: const Text(
                        'Nama Penyadap',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _tapperMethod(),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 8.0,
                right: 8.0,
                bottom: 4.0,
              ),
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: const Text(
                        'NIK (Penyadap)',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _nikMethod(),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 8.0,
                right: 8.0,
                bottom: 4.0,
              ),
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: const Text(
                        'Kemandoran',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _kemandoranMethod(),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 8.0,
                right: 8.0,
                bottom: 4.0,
              ),
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: const Text(
                        'Sub Divisi',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _subDivMethod(),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 8.0,
                right: 8.0,
                bottom: 4.0,
              ),
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: const Text(
                        'Sistem Sadap',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _sistemSadapMethod(),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 8.0,
                right: 8.0,
                bottom: 4.0,
              ),
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: const Text(
                        'Task',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _taskMethod(),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 8.0,
                right: 8.0,
                bottom: 4.0,
              ),
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: const Text(
                        'Kategori Kulit Sadapan',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _kategoriMethod(),
            SizedBox(height: 5.0),
            _submitBtnMethod(context),
          ],
        ),
      ),
    );
  }

  Padding _submitBtnMethod(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        top: 8.0,
        right: 8.0,
        bottom: 4.0,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InputAssesmentBo()),
          );
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
    );
  }

  Padding _topBarMethod() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 4.0, right: 8.0),
      child: Container(
        height: 30,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                bottom: 4.0,
                right: 8.0,
              ),
              child: const Text(
                'Input Penilaian Sadap Bawah (BO)',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _dateMethod(BuildContext context, List<DateTime?> dates) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          onPressed: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (selectedDate != null) {
              setState(() {
                dates = [selectedDate]; // Update the selected date
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dates.isNotEmpty && dates[0] != null
                    ? "${dates[0]!.day}/${dates[0]!.month}/${dates[0]!.year}" // Display selected date
                    : "Pilih Tanggal", // Placeholder text
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const Icon(
                Icons.calendar_today,
                color: Colors.black,
              ), // Calendar icon
            ],
          ),
        ),
      ),
    );
  }

  Padding _tapperMethod() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(color: Colors.transparent),
        child: DropdownMenu<TapperModel>(
          controller: _getTapperController,
          width: double.infinity,
          hintText: 'Pilih Penyadap',
          requestFocusOnTap: true,
          enableFilter: true,
          dropdownMenuEntries:
              TapperModel.getTapperList()
                  .map(
                    (item) => DropdownMenuEntry<TapperModel>(
                      label: item.name,
                      value: item,
                    ),
                  )
                  .toList(),
          onSelected:
              (value) => setState(() {
                selectedTapper = value; // Update selected tapper
                selectedNik = value?.nik; // Update selected NIK
                selectedKemandoran =
                    value?.kemandoran; // Update selected Kemandoran
                selectedSubDivisi =
                    value?.subDivisi; // Update selected Sub Divisi

                // Update controllers to reflect the selected values
                _getNikController.text = selectedNik ?? '';
                _getKemandoranController.text = selectedKemandoran ?? '';
                _getSubDivisiController.text = selectedSubDivisi ?? '';
              }),
        ),
      ),
    );
  }

  Padding _nikMethod() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(color: Colors.transparent),
        child: DropdownMenu<String>(
          controller: _getNikController,
          width: double.infinity,
          hintText: 'NIK',
          requestFocusOnTap: true,
          enableFilter: true,
          dropdownMenuEntries: [
            if (selectedNik != null)
              DropdownMenuEntry<String>(
                label: selectedNik!,
                value: selectedNik!,
              ),
          ],
          onSelected:
              (value) => setState(() {
                selectedNik = value; // Update selected NIK
              }),
        ),
      ),
    );
  }

  Padding _kemandoranMethod() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(color: Colors.transparent),
        child: DropdownMenu<String>(
          controller: _getKemandoranController,
          width: double.infinity,
          hintText: 'Kemandoran',
          requestFocusOnTap: true,
          enableFilter: true,
          dropdownMenuEntries: [
            if (selectedKemandoran != null)
              DropdownMenuEntry<String>(
                label: selectedKemandoran!,
                value: selectedKemandoran!,
              ),
          ],
          onSelected:
              (value) => setState(() {
                selectedKemandoran = value; // Update selected tapper
              }),
        ),
      ),
    );
  }

  Padding _subDivMethod() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(color: Colors.transparent),
        child: DropdownMenu<String>(
          controller: _getSubDivisiController,
          width: double.infinity,
          hintText: 'Sub Divisi',
          requestFocusOnTap: true,
          enableFilter: true,
          dropdownMenuEntries: [
            if (selectedSubDivisi != null)
              DropdownMenuEntry<String>(
                label: selectedSubDivisi!,
                value: selectedSubDivisi!,
              ),
          ],
          onSelected:
              (value) => setState(() {
                selectedSubDivisi = value; // Update selected tapper
              }),
        ),
      ),
    );
  }

  Padding _sistemSadapMethod() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(color: Colors.transparent),
        child: DropdownMenu<String>(
          controller: _getTappingSystemController,
          width: double.infinity,
          hintText: 'Sistem Sadap',
          requestFocusOnTap: true,
          enableFilter: true,
          dropdownMenuEntries: [
            DropdownMenuEntry<String>(
              label: 'Sadapan Atas (HO)',
              value: 'Sadapan Atas',
            ),
            DropdownMenuEntry<String>(
              label: 'Sadapan Bawah (BO)',
              value: 'Sadapan Bawah',
            ),
          ],
          onSelected:
              (value) => setState(() {
                selectedTappingSystem = value; // Update selected tapper
              }),
        ),
      ),
    );
  }

  Padding _taskMethod() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(color: Colors.transparent),
        child: DropdownMenu<String>(
          controller: _getTaskController,
          width: double.infinity,
          hintText: 'Task',
          requestFocusOnTap: true,
          enableFilter: true,
          dropdownMenuEntries: [
            DropdownMenuEntry<String>(label: 'Task A', value: 'Task A'),
            DropdownMenuEntry<String>(label: 'Task B', value: 'Task B'),
            DropdownMenuEntry<String>(label: 'Task C', value: 'Task C'),
          ],
          onSelected:
              (value) => setState(() {
                selectedTask = value; // Update selected tapper
              }),
        ),
      ),
    );
  }

  Padding _kategoriMethod() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(color: Colors.transparent),
        child: DropdownMenu<String>(
          controller: _getCategoryController,
          width: double.infinity,
          hintText: 'Kategori Kulit Sadapan',
          requestFocusOnTap: true,
          enableFilter: true,
          dropdownMenuEntries: [
            DropdownMenuEntry<String>(label: 'Kategori A', value: 'Kategori A'),
            DropdownMenuEntry<String>(label: 'Kategori B', value: 'Kategori B'),
          ],
          onSelected:
              (value) => setState(() {
                selectedCategory = value; // Update selected tapper
              }),
        ),
      ),
    );
  }
}
