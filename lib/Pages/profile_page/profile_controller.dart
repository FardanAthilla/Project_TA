import 'package:get/get.dart';
import 'package:project_ta/Pages/login_page/auth/token.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  RxMap<String, dynamic>? userData = RxMap<String, dynamic>();

  Future<void> fetchUserData() async {
    try {
      final String? token = await getToken();

      if (token != null) {
        final userData = await getUserDataFromApi(token);
        this.userData!.value = userData;
      } else {
        throw Exception('Token not found');
      }
    } catch (e) {
      throw Exception('Failed to fetch user data: $e');
    }
  }

  Future<Map<String, dynamic>> getUserDataFromApi(String token) async {
      Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json', 
  };
    try {
      final Uri apiUrl = Uri.parse('https://rdo-app-o955y.ondigitalocean.app/userAuth/getUser');
      final response = await http.post(
        apiUrl,
        headers: headers
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        return userData;
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }
    void resetUserData() {
    userData?.value = {};
  }
}
