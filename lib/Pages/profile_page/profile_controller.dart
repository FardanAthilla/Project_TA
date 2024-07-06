import 'package:get/get.dart';
import 'package:project_ta/Pages/login_page/auth/token.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  RxMap<String, dynamic>? userData = RxMap<String, dynamic>();
  RxBool isLoading = false.obs;

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
        headers: headers,
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

  Future<void> updateUser(Map<String, dynamic> userData) async {
    try {
      final String? token = await getToken();
      if (token != null) {
        final response = await http.put(
          Uri.parse('https://rdo-app-o955y.ondigitalocean.app/user'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(userData),
        );

        if (response.statusCode == 200) {
          fetchUserData();
        } else {
          throw Exception('Failed to update user data');
        }
      } else {
        throw Exception('Token not found');
      }
    } catch (e) {
      throw Exception('Failed to update user data: $e');
    }
  }

  Future<void> updateUserPhoto(int userId, XFile image) async {
    try {
      final String? token = await getToken();
      if (token != null) {
        var request = http.MultipartRequest(
          'PUT',
          Uri.parse('https://rdo-app-o955y.ondigitalocean.app/user/foto/$userId'),
        );
        request.headers['Authorization'] = 'Bearer $token';
        request.headers['Content-Type'] = 'multipart/form-data';
        request.files.add(await http.MultipartFile.fromPath('image', image.path));

        var response = await request.send();
        if (response.statusCode == 200) {
          fetchUserData();
        } else {
          throw Exception('Failed to update user photo');
        }
      } else {
        throw Exception('Token not found');
      }
    } catch (e) {
      throw Exception('Failed to update user photo: $e');
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
