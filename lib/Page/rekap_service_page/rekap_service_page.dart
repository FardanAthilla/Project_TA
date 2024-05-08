import 'package:flutter/material.dart';
import 'package:project_ta/Page/rekap_service_page/widgets/buildrow.dart';

class RekapLaporanService extends StatelessWidget {
  const RekapLaporanService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Rekap Laporan Penjualan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black, width: 1.0), 
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 0, 
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BuildRow(label: 'Tanggal:', text: '23-01-2025'),
                                BuildRow(label: 'Cabang:', text: 'Menara'),
                                BuildRow(label: 'Nama barang:', text: 'Mesin jack f3'),
                                BuildRow(label: 'Jumlah:', text: '1'),
                                BuildRow(label: 'Jumlah:', text: '1'),
                                BuildRow(label: 'Jumlah:', text: '1'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}