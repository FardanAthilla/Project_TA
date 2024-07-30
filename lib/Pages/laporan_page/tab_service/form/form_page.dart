import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/laporan_page/tab_service/form/form_controller.dart';
import 'package:project_ta/Pages/laporan_page/widget/widget.dart';
import 'package:project_ta/Pages/profile_page/profile_controller.dart';
import 'package:project_ta/color.dart';

class FormLaporanService extends StatelessWidget {
  final ServiceController serviceController = Get.put(ServiceController());
  final ProfileController profileController = Get.put(ProfileController());
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final DateController dateController;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController machineNameController = TextEditingController();
  final TextEditingController complaintsController = TextEditingController();

  FormLaporanService({
    required this.dateController,
  });

  @override
  Widget build(BuildContext context) {
    final userId = profileController.userData?['user_id'] ?? 0;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Laporan Service'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  DateTextField(
                    dateController: dateController,
                    title: 'Tanggal, Bulan, Tahun',
                    description: 'Pilih tanggal menggunakan kalender.',
                  ),
                  const SizedBox(height: 15),
                  EditableTextField(
                    title: 'Nama Orang Pemilik Mesin',
                    controller: nameController,
                    maxLength: 20,
                  ),
                  EditableTextField(
                    title: 'Nama Mesin Yang Di Service',
                    controller: machineNameController,
                    maxLength: 20,
                  ),
                  EditableTextField(
                    title: 'Keluhan Yang Di Alami',
                    controller: complaintsController,
                    maxLines: 4,
                    maxLength: 120,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BottomBarButton(
                        text: 'Bersihkan',
                        backgroundColor: Colors.white,
                        textColor: Warna.danger,
                        borderColor: Warna.danger,
                        onPressed: () {
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
                                      nameController.clear();
                                      machineNameController.clear();
                                      complaintsController.clear();
                                      dateController.clear();
                                      Get.back();
                                    },
                                  ),
                                ],
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
                                    if (nameController.text.isEmpty ||
                                        machineNameController.text.isEmpty ||
                                        complaintsController.text.isEmpty ||
                                        dateController.apiDate.value.isEmpty) {
                                      if (!serviceController.isSnackbarActive) {
                                        serviceController.isSnackbarActive =
                                            true;
                                        Get.snackbar(
                                          'Gagal Mengirim',
                                          'Silahkan isi semua datanya',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Warna.danger,
                                          colorText: Warna.teksactive,
                                        );
                                        Future.delayed(Duration(seconds: 3),
                                            () {
                                          serviceController.isSnackbarActive =
                                              false;
                                        });
                                      }
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
                                            'Apakah Anda yakin untuk mengirimkan laporan Service?',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
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
                                                isLoading.value = true;
                                                final request = {
                                                  'date': dateController
                                                      .apiDate.value,
                                                  'user_id': userId,
                                                  'name': nameController.text,
                                                  'machine_name':
                                                      machineNameController
                                                          .text,
                                                  'complaints':
                                                      complaintsController.text,
                                                };

                                                try {
                                                  await serviceController
                                                      .sendServiceRequest(
                                                          request, userId);
                                                } finally {
                                                  isLoading.value = false;
                                                  dateController.clear();
                                                }
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
          ),
        ),
      ),
    );
  }
}
