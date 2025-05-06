import 'package:get/get.dart';

class AssessmentBoController extends GetxController {
  var selectedDate = DateTime.now().obs;

  void updateDate(DateTime date) {
    selectedDate.value = date;
  }
}
