import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_ta/Page/login_page/auth/token.dart';

  Future<Map<String, dynamic>> getUserData() async {
    final String? token = await getToken();
    if (token != null) {
      try {
        final userData = await getUserDataFromApi(token);
        return userData;
      } catch (e) {
        throw Exception('Failed to fetch user data: $e');
      }
    } else {
      throw Exception('Token not found');
    }
  }

  Future<Map<String, dynamic>> getUserDataFromApi(String Token) async {
    final Uri apiUrl = Uri.parse('https://secure-sawfly-certainly.ngrok-free.app/userAuth/getUser');
    try {
      final response = await http.post(
        apiUrl,
        body: {'Token': Token}, 
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        return userData;
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

