import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_mesin.dart';
import 'package:project_ta/Pages/daftar_page/controllers/controller_sparepart.dart';
import 'package:project_ta/Pages/laporan_page/Mesin/daftar_mesin_page.dart';
import 'package:project_ta/Pages/laporan_page/Mesin/itemselection.dart';
import 'package:project_ta/Pages/laporan_page/models/model_selection_item.dart';
import 'package:project_ta/Pages/laporan_page/widget/custom_tabbar.dart';
import 'package:project_ta/Pages/laporan_page/widget/widget.dart';
import 'package:project_ta/Pages/rekap_laporan_page/controllers/controller.dart';
import 'package:project_ta/color.dart';

class LaporanPage extends StatelessWidget {
  final ItemSelectionController itemSelectionController =
      Get.put(ItemSelectionController());
      final SalesReportController salesReportController = Get.put(SalesReportController());
  final StoreController storeController = Get.put(StoreController());
  final SparepartController sparepartController =
      Get.put(SparepartController());
  final DateController dateController = Get.put(DateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'Assets/logo2.svg',
              width: 30,
              height: 30,
            )
          ],
        ),
      ),
      body: CustomTabBar(
        tabs: const [
          Tab(text: 'Penjualan'),
          Tab(text: 'Service'),
        ],
        tabViews: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9.0),
                      boxShadow: [
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
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => DaftarMesinPage(
                          itemSelectionController: itemSelectionController));
                      
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 0.5,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Daftar Barang'),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Obx(() {
                    if (itemSelectionController.selectedItems.isEmpty) {
                      return SizedBox.shrink();
                    } else {
                      return Column(
                        children: [
                          ...itemSelectionController.selectedItems
                              .map((entry) {
                            final item = entry.item;
                            final quantity = entry.quantity;
                            return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Warna.teksactive,
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 1.0,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    title: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: Image.asset(
                                          entry.category == "mesin" ? 'Assets/iconlistmesin3.png' : 'Assets/iconsparepart.png',
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
                                        itemSelectionController.deselectItem(SelectedItems(
                                          categoryItemsId: entry.categoryItemsId,
                                          category: entry.category == "mesin" ? "mesin" : "spare_part",
                                          price: entry.price,
                    id: entry.id,
                    item: item,
                    quantity: 1,
                  ));
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
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
                      BottomBarButton(
                        text: 'Bersihkan',
                        backgroundColor: Colors.white,
                        textColor: Warna.danger,
                        borderColor: Warna.danger,
                        onPressed: () {
                          dateController.clear();
                          itemSelectionController.selectedItems.clear();
                        },
                      ),
                      SizedBox(width: 10),
                      BottomBarButton(
                        text: 'Kirim',
                        backgroundColor: Warna.main,
                        textColor: Colors.white,
                        borderColor: Warna.main,
                        onPressed: () async {
                          salesReportController.sendSalesReport(dateController,itemSelectionController.selectedItems);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Placeholder(),
        ],
      ),
    );
  }
}
