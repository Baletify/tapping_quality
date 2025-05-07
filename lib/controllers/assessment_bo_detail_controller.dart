import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapping_quality/models/user_model.dart';
import 'package:tapping_quality/services/user_service.dart';

class AssessmentBoDetailController extends GetxController {
  var selectedDate = DateTime.now().obs;

  var userList = <UserModel>[].obs;
  var filteredUsers = <UserModel>[].obs;
  var selectedUser = Rx<UserModel?>(null);
  var treeSkinType = ['Perawan', 'Pulihan', 'NTA'].obs;
  var tappingPanel = ['HO', 'VH', 'GO'].obs;

  final nikController = TextEditingController();
  final kemandoranController = TextEditingController();
  final departemenController = TextEditingController();
  final statusController = TextEditingController();
  final treeSkinTypeController = TextEditingController();
  final tappingPanelController = TextEditingController();

  void updateDate(DateTime date) {
    selectedDate.value = date;
  }

  @override
  void onInit() async {
    super.onInit();
    // Initialize the user list
    treeSkinType = ['Perawan', 'Pulihan', 'NTA'].obs;
    tappingPanel = ['HO', 'VH', 'GO'].obs;

    try {
      // Fetch users from the UserService
      final users = await UserService().getAllUsers();
      userList.value = users;
      filteredUsers.value = users; // Initially, show all users
    } catch (e) {
      print('Error fetching users: $e');
      userList.value = [];
      filteredUsers.value = [];
    }
  }

  // Method to filter users based on search query
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

  // Method to update the selected user
  void updateSelectedUser(UserModel? user) {
    selectedUser.value = user;
    nikController.text = user?.nik ?? '';
    kemandoranController.text = user?.kemandoran ?? '';
    departemenController.text = user?.departemen ?? '';
    statusController.text = user?.status ?? '';
  }

  void updateTreeSkinType(String type) {
    treeSkinTypeController.text = type;
  }

  void updateTappingPanel(String panel) {
    tappingPanelController.text = panel;
  }
}
