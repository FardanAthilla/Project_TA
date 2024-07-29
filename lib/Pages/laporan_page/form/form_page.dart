import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/laporan_page/form/form_controller.dart';
import 'package:project_ta/Pages/laporan_page/widget/widget.dart';
import 'package:project_ta/Pages/profile_page/profile_controller.dart';

class FormLaporanService extends StatelessWidget {
  final ServiceController serviceController = Get.put(ServiceController());
  final ProfileController profileController = Get.put(ProfileController());

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
        appBar: AppBar(title: Text('Service Request')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DateTextField(
                dateController: dateController,
                title: 'Tanggal, Bulan, Tahun',
                description: 'Pilih tanggal menggunakan kalendar.',
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: machineNameController,
                decoration: InputDecoration(labelText: 'Machine Name'),
              ),
              TextField(
                controller: complaintsController,
                decoration: InputDecoration(labelText: 'Complaints'),
              ),
              SizedBox(height: 20),
              Obx(() {
                return serviceController.isLoading.value
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          final request = {
                            'date': dateController,
                            'user_id': userId,
                            'name': nameController.text,
                            'machine_name': machineNameController.text,
                            'complaints': complaintsController.text,
                          };
                          serviceController.sendServiceRequest(request);
                        },
                        child: Text('Send Request'),
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
