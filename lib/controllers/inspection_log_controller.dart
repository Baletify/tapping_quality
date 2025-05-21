import 'package:get/get.dart';
import 'package:tapping_quality/models/user_model.dart';
import 'package:tapping_quality/services/assessment_result_service.dart';
import 'package:tapping_quality/services/user_service.dart';

class InspectionLogController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var userList = <UserModel>[].obs;
  var filteredUsers = <UserModel>[].obs;
  var selectedUser = Rxn<UserModel>();
  var isSearched = false.obs;
  var assessmentReport = <Map<String, dynamic>>[].obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      // Fetch users from the UserService
      final users = await UserService().getTapperByDepartment('Sub Divisi A');
      userList.value = users;
      filteredUsers.value = users;
    } catch (e) {
      print('Error fetching users: $e');
      userList.value = [];
      filteredUsers.value = [];
    }
  }

  void updateDate(DateTime date) {
    selectedDate.value = date;
  }

  void filterUsers(String query) {
    if (query.isEmpty) {
      filteredUsers.value = userList;
    } else {
      filteredUsers.value =
          userList
              .where(
                (user) => user.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
  }

  void updateSelectedUser(UserModel? user) {
    selectedUser.value = user;
    // print('Selected User: ${user?.nik}');
  }

  fetchAssessmentReport(String nik, dynamic date) async {
    final service = AssessmentResultService();
    final data = await service.getAssessmentReport(nik, date);

    assessmentReport.assignAll(data);
    // print('Assessment Report: $assessmentReport');
  }
}
