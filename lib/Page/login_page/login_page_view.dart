  import 'package:flutter/material.dart';
  import 'package:flutter_svg/svg.dart';
  import 'package:get/get.dart';
  import 'package:project_ta/Page/sidebar/sidebar.dart';
  import 'package:project_ta/color.dart';

 class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'Assets/login3.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned( 
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Warna.background, 
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
              height: height / 1.40,
              width: width, // Lebar Container mengikuti lebar layar
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [     
                  SvgPicture.asset(
                    "Assets/logo2.svg",
                    width: 1000,
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Selamat datang!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Mohon login untuk melanjutkan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Username",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Warna.card
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none
                          ),
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(Navigation());
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
