import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Page/login_page/auth/token.dart';
import 'package:project_ta/Page/profile_page/profile_controller.dart';
import 'package:project_ta/color.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  Future<void> _refreshData() async {
    await profileController.fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Profile Page')),
          ),
          body: RefreshIndicator(
            onRefresh: _refreshData,
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Center(
                child: FutureBuilder(
                  future: Future.delayed(Duration(seconds: 2)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        profileController.userData == null ||
                        profileController.userData!.isEmpty) {
                      return _buildShimmerEffect(screenWidth);
                    } else {
                      final userData = profileController.userData!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 25),
                            child: CircleAvatar(
                              radius: screenWidth * 0.18,
                              backgroundImage: NetworkImage(
                                'https://secure-sawfly-certainly.ngrok-free.app/' +
                                    userData['image'],
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 30,
                                color: Warna.main,
                              ),
                              Padding(
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
                                    Text(
                                      '${userData['username']}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Icon(
                                Icons.business,
                                size: 30,
                                color: Warna.main,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        'Cabang:',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(width: 100),
                                    Text(
                                      '${userData['branch']}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Divider(),
                          Spacer(),
                          ElevatedButton.icon(
                            onPressed: () async {
                              await removeToken();
                              Get.offAllNamed('/splash');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Warna.danger,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            icon: Icon(
                              Icons.logout,
                              color: Warna.white,
                            ),
                            label: Text(
                              "Keluar",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Warna.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          )),
    );
  }

  Widget _buildShimmerEffect(double screenWidth) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 25),
            child: CircleAvatar(
              radius: screenWidth * 0.18,
              backgroundColor: Colors.white,
            ),
          ),
          SizedBox(width: 12),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 30,
                color: Warna.main,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: screenWidth * 0.3,
                      height: 20,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: screenWidth * 0.5,
                      height: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Divider(),
          Row(
            children: [
              Icon(
                Icons.business,
                size: 30,
                color: Warna.main,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: screenWidth * 0.3,
                      height: 20,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: screenWidth * 0.5,
                      height: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Divider(),
          Spacer(),
          Container(
            width: double.infinity,
            height: 50,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
