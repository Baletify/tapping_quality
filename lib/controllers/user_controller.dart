import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  var userName = ''.obs;
  var userID = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserName();
  }

  void loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('name') ?? '';
    userID.value = prefs.getInt('id') ?? 0;
  }
}
