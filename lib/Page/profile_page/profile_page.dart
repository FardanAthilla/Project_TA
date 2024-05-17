import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Page/login_page/auth/token.dart';
import 'package:project_ta/Page/profile_page/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Obx(() {    
        if (profileController.userData!.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final userData = profileController.userData!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      '${userData['username']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0, left: 10),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await removeToken();
                        Get.offAllNamed('/splash');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Logout",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      }),
    );
  }
}
