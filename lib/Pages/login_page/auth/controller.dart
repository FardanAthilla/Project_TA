import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> loginUser(String username, String password) async {
  final Uri apiUrl = Uri.parse('https://rdo-app-o955y.ondigitalocean.app/login');
  final Map<String, String> requestBody = {'username': username, 'password': password};

  try {
    final response = await http.post(
      apiUrl,
      body: jsonEncode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String token = responseData['Token'];
      return token;
    } else {
      throw Exception('Failed to login');
    }
  } catch (e) {
    throw Exception('Failed to connect to the server');
  }
}