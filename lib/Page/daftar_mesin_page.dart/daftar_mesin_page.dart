import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ta/Models/controller.dart';
import 'package:project_ta/Models/product_response_api.dart';
import 'package:project_ta/Page/sidebar/navigation.dart';
import 'package:project_ta/color.dart';

class DaftarMesinPage extends StatelessWidget {
  const DaftarMesinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());
    final productController = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async {
        navigationController.selectedIndex.value = 0;
        return true;
      },
      child: DefaultTabController(
        length: 6,
        child: Scaffold(
          backgroundColor: Warna.background,
          body: Column(
            children: [
              Container(
                child: TabBar(
                  isScrollable: true,
                  labelColor: Warna.main,
                  indicatorColor: Warna.main,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    Tab(text: 'Barang'),
                    Tab(text: 'Iwak'),
                    Tab(text: 'Sapi'),
                    Tab(text: 'Ayam'),
                    Tab(text: 'Basreng'),
                    Tab(text: 'Nasgor'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Obx(() {
                      if (productController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        List<ProductResponseModel> displayedProducts =
                            productController.productList.isEmpty
                                ? []
                                : productController.productList
                                    .take(20)
                                    .toList();
                        return ListView.builder(
                          itemCount: displayedProducts.length,
                          itemBuilder: (context, index) {
                            final product = displayedProducts[index];
                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.all(10),
                              color: Warna.main,
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(8),
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right:
                                                8.0), // Atur jarak di sebelah kanan teks judul
                                        child: Text(
                                          product.title,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Price: \$${product.price}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }),

                    // Tab 2 Content
                    Center(
                      child: Text('Content Tab 2'),
                    ),

                    // Tab 3 Content
                    Center(
                      child: Text('Content Tab 3'),
                    ),

                    // Tab 4 Content
                    Center(
                      child: Text('Content Tab 4'),
                    ),

                    // Tab 5 Content
                    Center(
                      child: Text('Content Tab 5'),
                    ),

                    // Tab 6 Content
                    Center(
                      child: Text('Content Tab 6'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}