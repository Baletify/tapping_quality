import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapping_quality/models/tapper_model.dart';

class AddAssessmentBoController extends GetxController {
  // Reactive variables for dropdowns
  var selectedTapper = Rxn<TapperModel>();
  var selectedNik = RxnString();
  var selectedKemandoran = RxnString();
  var selectedSubDivisi = RxnString();
  var selectedTappingSystem = RxnString();
  var selectedTask = RxnString();
  var selectedCategory = RxnString();

  // Date selection
  var selectedDate = Rxn<DateTime>();

  // Dropdown controllers
  final tapperController = TextEditingController();
  final nikController = TextEditingController();
  final kemandoranController = TextEditingController();
  final subDivisiController = TextEditingController();
  final tappingSystemController = TextEditingController();
  final taskController = TextEditingController();
  final categoryController = TextEditingController();

  // Update dropdown values
  void updateTapper(TapperModel? tapper) {
    selectedTapper.value = tapper;
    selectedNik.value = tapper?.nik;
    selectedKemandoran.value = tapper?.kemandoran;
    selectedSubDivisi.value = tapper?.subDivisi;

    // Update text controllers
    nikController.text = selectedNik.value ?? '';
    kemandoranController.text = selectedKemandoran.value ?? '';
    subDivisiController.text = selectedSubDivisi.value ?? '';
  }

  void updateDate(DateTime? date) {
    selectedDate.value = date;
  }

  void updateTappingSystem(String? value) {
    selectedTappingSystem.value = value;
  }

  void updateTask(String? value) {
    selectedTask.value = value;
  }

  void updateCategory(String? value) {
    selectedCategory.value = value;
  }
}
