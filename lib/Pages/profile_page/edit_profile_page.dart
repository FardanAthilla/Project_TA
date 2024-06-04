import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Pages/profile_page/profile_controller.dart';
import 'package:project_ta/color.dart';

class EditProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  EditProfilePage({super.key}) {
    final userData = profileController.userData!;
    nameController.text = userData['username'];
    phoneController.text = '+62 ${userData['no_handphone']}'; // Added '+62'
    addressController.text = userData['address'];
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
                    child: CircleAvatar(
                      radius: screenWidth * 0.18,
                      backgroundImage: NetworkImage(
                        'https://rdo-app-o955y.ondigitalocean.app/' +
                            profileController.userData!['image'],
                      ),
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
                                  isDense: true, // Reduces height of TextField
                                  contentPadding: EdgeInsets.only(bottom: 5), // Adjusts padding
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
                                  isDense: true, // Reduces height of TextField
                                  contentPadding: EdgeInsets.only(bottom: 5), // Adjusts padding
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
                                  isDense: true, // Reduces height of TextField
                                  contentPadding: EdgeInsets.only(bottom: 5), // Adjusts padding
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
                  ElevatedButton(
                    onPressed: () async {
                      final String password = passwordController.text.isEmpty ? "" : passwordController.text;
                      await profileController.updateUserData(
                        name: nameController.text,
                        phone: phoneController.text,
                        address: addressController.text,
                        password: password,
                      );
                      await profileController.fetchUserData();
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Warna.main,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
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
