import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  static Future<void> postDataToSalesAPI({
    required String date,
    required String branch,
    required String item,
    required int quantity,
  }) async {
    final String url = 'https://secure-sawfly-certainly.ngrok-free.app/sales';
    final Map<String, dynamic> data = {
      "Date": date,
      "Branch": branch,
      "Item": item,
      "Quantity": quantity
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print('Data berhasil dikirim ke server');
      } else {
        throw Exception('Gagal mengirim data ke server');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
