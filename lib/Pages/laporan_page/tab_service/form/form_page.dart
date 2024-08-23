import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
  final Rxn<XFile> selectedImage = Rxn<XFile>();

  FormLaporanService({
    required this.dateController,
  });

  @override
  Widget build(BuildContext context) {
    final userId = profileController.userData?['user_id'] ?? 0;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Laporan Service'),
          surfaceTintColor: Warna.background,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Foto mesin yang di service',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.photo_library),
                                  title: Text('Pilih dari Galeri'),
                                  onTap: () async {
                                    selectedImage.value = await picker
                                        .pickImage(source: ImageSource.gallery);
                                    Get.back();
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.camera_alt),
                                  title: Text('Ambil Foto'),
                                  onTap: () async {
                                    selectedImage.value = await picker
                                        .pickImage(source: ImageSource.camera);
                                    Get.back();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Obx(() {
                        return Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5), width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: selectedImage.value != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.file(
                                    File(selectedImage.value!.path),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Pilih foto",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                    DateTextField(
                      dateController: dateController,
                      title: 'Tanggal, Bulan, Tahun',
                      description: '',
                    ),
                    EditableTextField(
                      title: 'Nama Orang Pemilik Mesin',
                      controller: nameController,
                      maxLength: 20,
                      subtitle: "Masukkan Nama Pelanggan",
                    ),
                    EditableTextField(
                      title: 'Nama Mesin Yang Di Service',
                      controller: machineNameController,
                      maxLength: 20,
                      subtitle: "Masukkan Nama Mesin",
                    ),
                    EditableTextField(
                      title: 'Keluhan Yang Di Alami',
                      controller: complaintsController,
                      maxLines: 4,
                      maxLength: 120,
                      subtitle: "Keluhan Yang Dialami",
                    ),
                    const SizedBox(height: 20),
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
                                  title: const Text(
                                    'Konfirmasi',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: const Text(
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
                                        selectedImage.value = null;
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
                                  ? const Color.fromARGB(151, 203, 203, 203)
                                  : Warna.main,
                              onPressed: value
                                  ? null
                                  : () {
                                      if (nameController.text.isEmpty ||
                                          machineNameController.text.isEmpty ||
                                          complaintsController.text.isEmpty ||
                                          dateController
                                              .apiDate.value.isEmpty ||
                                          selectedImage.value == null) {
                                        if (!serviceController
                                            .isSnackbarActive) {
                                          serviceController.isSnackbarActive =
                                              true;
                                          Get.snackbar(
                                            'Gagal Mengirim',
                                            'Silahkan isi semua datanya termasuk gambar',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Warna.danger,
                                            colorText: Warna.teksactive,
                                          );
                                          Future.delayed(
                                              const Duration(seconds: 3), () {
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
                                            title: const Text(
                                              'Konfirmasi',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            content: const Text(
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
                                                        complaintsController
                                                            .text,
                                                    'image': selectedImage
                                                        .value?.path,
                                                  };

                                                  try {
                                                    await serviceController
                                                        .sendServiceRequest(
                                                            request, userId);
                                                  } finally {
                                                    isLoading.value = false;
                                                    dateController.clear();
                                                    selectedImage.value = null;
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
      ),
    );
  }
}
