import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project_ta/Pages/laporan_page/widget/widget.dart';
import 'package:project_ta/color.dart';

class SalesReportController extends GetxController {
  RxList salesData = [].obs;
  RxList filteredSalesData = [].obs;
  var isLoading = false.obs;

  Future<void> fetchSalesReport() async {
    final response = await http
        .get(Uri.parse('https://rdo-app-o955y.ondigitalocean.app/sales'));

    if (response.statusCode == 200) {
      salesData.value = json.decode(response.body)['Data'];
    } else {
      throw Exception('Failed to load sales report');
    }
  }

void sendSalesReport(DateController date, List selectedItems) async {
  isLoading(true);
  final response = await http.post(
    Uri.parse('https://rdo-app-o955y.ondigitalocean.app/sales'),
    body: jsonEncode({
      "date": date.date.value,
      "item": selectedItems,
    }),
  );
  isLoading(false);
  if (response.statusCode == 200) {
    selectedItems.clear();
    date.clear();
  } else {
    print('${response.body}');
    Get.snackbar(
      'Gagal Mengirim',
      'Terjadi kesalahan. Silahkan isi semua datanya',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Warna.danger,
      colorText: Warna.teksactive,
    );
    print(response.body);
  }
}

  @override
  void onInit() {
    super.onInit();
    fetchSalesReport();
  }
}
