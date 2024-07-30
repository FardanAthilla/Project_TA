// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_ta/Pages/navigation/navbar_view.dart';
import 'package:project_ta/Pages/profile_page/profile_controller.dart';
import 'package:project_ta/color.dart';

class EditProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  var _image = Rx<XFile?>(null);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  EditProfilePage({super.key}) {
    final userData = profileController.userData!;
    nameController.text = userData['username'];
    phoneController.text = userData['no_handphone'];
    addressController.text = userData['address'];
  }

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _image.value = pickedImage;
    }
  }

  Future<void> _saveChanges() async {
    if (nameController.text.isEmpty ||
        addressController.text.isEmpty ||
        phoneController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Semua Field harus diisi kecuali password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Warna.danger,
        colorText: Colors.white,
      );
      return;
    }

    if (passwordController.text.isNotEmpty &&
        (passwordController.text.length < 8 ||
            !passwordController.text.contains(RegExp(r'[A-Z]')) ||
            !passwordController.text.contains(RegExp(r'[0-9]')))) {
      Get.snackbar(
        'Error',
        'Password harus memiliki minimal 8 karakter, satu huruf besar, satu angka',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Warna.danger,
        colorText: Colors.white,
      );
      return;
    }

    Map<String, dynamic> userData = {
      'id': profileController.userData!['user_id'],
      'username': nameController.text,
      'address': addressController.text,
      'no_handphone': phoneController.text,
    };

    if (passwordController.text.isNotEmpty) {
      userData['password'] = passwordController.text;
    }

    isLoading.value = true;

    await profileController.updateUser(userData);

    if (_image.value != null) {
      await profileController.updateUserPhoto(
          profileController.userData!['user_id'], _image.value!);
    }

    isLoading.value = false;
    Get.offAll(Navbar());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 25),
                    child: Stack(
                      children: [
                        Obx(() {
                          return CircleAvatar(
                            radius: screenWidth * 0.18,
                            backgroundImage: _image.value == null
                                ? NetworkImage(
                                    'https://rdo-app-o955y.ondigitalocean.app/${profileController.userData!['image']}')
                                : FileImage(File(_image.value!.path))
                                    as ImageProvider,
                          );
                        }),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Warna.main,
                                size: screenWidth * 0.08,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 30,
                        color: Warna.main,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  'Nama:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(bottom: 5),
                                  border: InputBorder.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 30,
                        color: Warna.main,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  'Nomor Handphone:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(bottom: 5),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 30,
                        color: Warna.main,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  'Alamat:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextField(
                                controller: addressController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(bottom: 5),
                                  border: InputBorder.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Icon(
                        Icons.lock,
                        size: 30,
                        color: Warna.main,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  'Password:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(bottom: 5),
                                  border: InputBorder.none,
                                ),
                                obscureText: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  ValueListenableBuilder<bool>(
                    valueListenable: isLoading,
                    builder: (context, loading, child) {
                      return ElevatedButton(
                        onPressed: loading ? null : _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Warna.main,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: loading
                            ? Text(
                                "Sedang memuat",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              )
                            : Text(
                                'Simpan',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                      );
                    },
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
