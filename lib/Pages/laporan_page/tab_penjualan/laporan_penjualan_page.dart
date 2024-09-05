import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_mesin.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_sparepart.dart';
import 'package:project_ta/Pages/laporan_page/tab_penjualan/daftar/daftar_mesin_page.dart';
import 'package:project_ta/Pages/laporan_page/tab_penjualan/daftar/itemselection.dart';
import 'package:project_ta/Pages/laporan_page/models/model_selection_item.dart';
import 'package:project_ta/Pages/laporan_page/widget/widget.dart';
import 'package:project_ta/Pages/laporan_page/controllers/controllersales.dart';
import 'package:project_ta/color.dart';

class SalesTabView extends StatelessWidget {
  final ItemSelectionController itemSelectionController;
  final StoreController storeController;
  final SparepartController sparepartController;
  final DateController dateController;
  final SalesReportController salesReportController;
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final SalesReportController salesController =
      Get.put(SalesReportController());

  SalesTabView({
    required this.itemSelectionController,
    required this.storeController,
    required this.sparepartController,
    required this.dateController,
    required this.salesReportController,
  });

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  strokeWidth: 4.0,
                ),
                const SizedBox(height: 20),
                Text(
                  'Mengirim...',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.5,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: DateTextField(
                dateController: dateController,
                title: 'Tanggal, Bulan, Tahun',
                description: 'Pilih tanggal menggunakan kalendar.',
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                storeController.ItemSelect(
                    storeController.searchControllerReport.text);
                sparepartController.SparePartSelect(
                    sparepartController.searchControllerReport.text);
                Get.to(() => DaftarMesinPage(
                    itemSelectionController: itemSelectionController));
              },
              child: Container(
                padding: const EdgeInsets.all(12.0),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 0.5,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pilih Barang'),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Obx(() {
              if (itemSelectionController.selectedItems.isEmpty) {
                return const SizedBox.shrink();
              } else {
                return Column(
                  children: [
                    ...itemSelectionController.selectedItems.map((entry) {
                      final item = entry.item;
                      final quantity = entry.quantity;
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Warna.teksactive,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 1.0,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.asset(
                                      entry.category == "mesin"
                                          ? 'Assets/iconlistmesin3.png'
                                          : 'Assets/iconsparepart.png',
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Warna.hitam,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          ('Rp.${entry.price} x $quantity'),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Warna.teks,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Warna.danger,
                                ),
                                onPressed: () {
                                  itemSelectionController.deselectItem(
                                      SelectedItems(
                                        categoryItemsId: entry.categoryItemsId,
                                        category: entry.category == "mesin"
                                            ? "mesin"
                                            : "spare_part",
                                        price: entry.price,
                                        id: entry.id,
                                        item: item,
                                        quantity: 1,
                                      ),
                                      (entry.id));
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      );
                    }).toList(),
                  ],
                );
              }
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(
                  () {
                    final isDisabled =
                        itemSelectionController.selectedItems.isEmpty;
                    return BottomBarButton(
                      text: 'Bersihkan',
                      backgroundColor: isDisabled
                          ? (Colors.grey[300] ?? Colors.grey)
                          : Colors.white,
                      textColor: isDisabled ? Colors.grey : Warna.danger,
                      borderColor: isDisabled ? Colors.grey : Warna.danger,
                      onPressed: isDisabled
                          ? null
                          : () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Konfirmasi',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Text(
                                      'Apakah Anda yakin untuk membersihkannya?',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
                                          'Batal',
                                          style: TextStyle(
                                            color: Warna.main,
                                          ),
                                        ),
                                        onPressed: () {
                                          Get.back();
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          'Ya',
                                          style: TextStyle(
                                            color: Warna.main,
                                          ),
                                        ),
                                        onPressed: () {
                                          dateController.clear();
                                          itemSelectionController
                                              .resetAllQuantities();
                                          itemSelectionController.selectedItems
                                              .clear();
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                    );
                  },
                ),
                const SizedBox(width: 10),
                ValueListenableBuilder<bool>(
                  valueListenable: isLoading,
                  builder: (context, value, child) {
                    return BottomBarButton(
                      text: value ? 'Mengirim...' : 'Kirim',
                      backgroundColor: Warna.main,
                      textColor: Colors.white,
                      borderColor: value
                          ? Color.fromARGB(151, 203, 203, 203)
                          : Warna.main,
                      onPressed: value
                          ? null
                          : () {
                              if (itemSelectionController
                                      .selectedItems.isEmpty ||
                                  dateController.displayDate.isEmpty) {
                                Get.snackbar(
                                  'Gagal Mengirim',
                                  'Terjadi kesalahan. Silahkan isi semua datanya',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Warna.danger,
                                  colorText: Warna.teksactive,
                                );
                                return;
                              }
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Konfirmasi',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Text(
                                      'Apakah Anda yakin untuk mengirimkan laporan penjualan?',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
                                          'Batal',
                                          style: TextStyle(
                                            color: Warna.main,
                                          ),
                                        ),
                                        onPressed: () {
                                          Get.back();
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          'Ya',
                                          style: TextStyle(
                                            color: Warna.main,
                                          ),
                                        ),
                                        onPressed: () async {
                                          Get.back();
                                          showLoadingDialog(context);
                                          isLoading.value = true;
                                          await salesReportController
                                              .sendSalesReport(
                                            dateController,
                                            itemSelectionController
                                                .selectedItems,
                                          );
                                          isLoading.value = false;
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
