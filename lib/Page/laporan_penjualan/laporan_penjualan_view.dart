import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Page/laporan_penjualan/widget/widget.dart';
import 'package:project_ta/Page/sidebar/navigation.dart';
import 'package:project_ta/color.dart';

class LaporanPenjualanPage extends StatefulWidget {
  final FocusNode? tanggalFocusNode;
  final FocusNode? cabangFocusNode;
  final FocusNode? namaBarangFocusNode;
  final FocusNode? jumlahBarangFocusNode;

  const LaporanPenjualanPage({
    Key? key,
    this.tanggalFocusNode,
    this.cabangFocusNode,
    this.namaBarangFocusNode,
    this.jumlahBarangFocusNode,
  }) : super(key: key);

  @override
  _LaporanPenjualanPageState createState() => _LaporanPenjualanPageState();
}

class _LaporanPenjualanPageState extends State<LaporanPenjualanPage> {
  String? _selectedCabang;
  TextEditingController _namaBarangController = TextEditingController();
  final NumberController _numberController = Get.put(NumberController());
  void _clearFields() {
    setState(() {
      _selectedCabang = null;
      _namaBarangController.text = '';
      _numberController.value.value = 0;
    });
  }

  @override
  void dispose() {
    _namaBarangController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());

    List<String> cabangOptions = [
      'Jl. Kyai Telingsing No.28',
      'Jl. Raya Kudus - Jepara No.424'
    ];

    return WillPopScope(
      onWillPop: () async {
        navigationController.selectedIndex.value = 0;
        return true;
      },
      child: GestureDetector(
        onTap: () {
          widget.tanggalFocusNode?.unfocus();
          widget.cabangFocusNode?.unfocus();
          widget.namaBarangFocusNode?.unfocus();
          widget.jumlahBarangFocusNode?.unfocus();
        },
        child: Scaffold(
          backgroundColor: Warna.background,
          body: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Laporan Penjualan',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 20),
                    DateTextField(
                      title: 'Tanggal,Bulan,Tahun',
                      description: 'Pilih tanggal menggunakan kalendar.',
                    ),
                    const SizedBox(height: 10),
                    DropdownFieldWithTitle(
                      title: 'Cabang',
                      description:
                          'Pilih lokasi terjadi nya transaksi dilakukan.',
                      value: _selectedCabang,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCabang = newValue;
                          if (newValue == 'Jl. Kyai Telingsing No.28') {
                            cabangOptions = [
                              'Jl. Kyai Telingsing No.28',
                              'Jl. Raya Kudus - Jepara No.424'
                            ];
                          } else {
                            cabangOptions = [
                              'Jl. Raya Kudus - Jepara No.424',
                              'Jl. Kyai Telingsing No.28'
                            ];
                          }
                        });
                      },
                      items: cabangOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    TextFieldWithTitle(
                      title: 'Nama Barang',
                      description: 'Nama Mesin/Spare part yang sudah dibeli',
                      focusNode: widget.namaBarangFocusNode,
                      controller: _namaBarangController,
                    ),
                    const SizedBox(height: 10),
                    NumberTextField(
                      title: 'Jumlah Barang',
                      description: 'Jumlah Mesin/Spare part yang sudah dibeli',
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            color: Warna.background,
            padding: const EdgeInsets.symmetric(vertical: 10),
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BottomBarButton(
                  text: 'Bersihkan',
                  backgroundColor: Colors.white,
                  textColor: Warna.danger,
                  borderColor: Warna.danger,
                  onPressed: () {
                    _clearFields();
                    _numberController.value.value = 0;
                  },
                ),
                BottomBarButton(
                  text: 'Kirim',
                  backgroundColor: Warna.main,
                  textColor: Colors.white,
                  borderColor: Warna.main,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
