// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl.dart';
// import 'package:project_ta/Pages/daftar_page/widget/custom_tabbar.dart';
// import 'package:project_ta/Pages/rekap_laporan_page/controllers/controllerserive.dart';
// import 'package:project_ta/Pages/rekap_laporan_page/widgets/shimmer.dart';
// import 'package:project_ta/color.dart';

// class RekapServicePage extends StatelessWidget {
//   final ServiceReportController controller = Get.put(ServiceReportController());

//   @override
//   Widget build(BuildContext context) {
//     initializeDateFormatting('id_ID', null);

//     return Scaffold(
//       appBar: AppBar(
//         surfaceTintColor: Warna.background,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SvgPicture.asset(
//               'Assets/logo2.svg',
//               width: 30,
//               height: 30,
//             ),
//           ],
//         ),
//       ),
//       body: RefreshIndicator(
//         onRefresh: controller.fetchSalesReport,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               Expanded(
//                 child: CustomTabBar(
//                   tabs: [
//                     Tab(text: 'ㅤMesinㅤ'),
//                     Tab(text: 'Service'),
//                   ],
//                   tabViews: [
//                     rekapMesinPage(context, controller),
//                     RekapServicePage(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget rekapMesinPage(BuildContext context, ServiceReportController controller) {
//     return Obx(() {
//       if (controller.salesData.isEmpty) {
//         return ShimmerLoading(); // Display shimmer loading widget
//       } else {
//         Map<String, List<dynamic>> groupedSales = {};
//         List<String> dates = [];

//         for (var data in controller.salesData) {
//           var date = DateTime.parse(data['date']);
//           var formattedDate =
//               DateFormat('EEEE, d MMMM y', 'id_ID').format(date);
//           if (!groupedSales.containsKey(formattedDate)) {
//             groupedSales[formattedDate] = [];
//             dates.insert(0, formattedDate);
//           }
//           groupedSales[formattedDate]?.add(data);
//         }

//         return SingleChildScrollView(
//           child: ListView.builder(
//             scrollDirection: Axis.vertical,
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: groupedSales.length,
//             itemBuilder: (context, index) {
//               var currentDate = dates[index];
//               var currentData = groupedSales[currentDate];

//               return GestureDetector(
//                 onTap: () {
//                   FocusScope.of(context).unfocus();
//                 },
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         currentDate,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: currentData!.length,
//                       itemBuilder: (context, index) {
//                         var data = currentData[index];
//                         return Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(12.0),
//                                     child: Image.asset(
//                                       'Assets/iconlistmesin3.png',
//                                       width: 52,
//                                       height: 52,
//                                       fit: BoxFit.contain,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 16),
//                                   Expanded(
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           data['item_name'],
//                                           style: TextStyle(
//                                             fontSize: 15,
//                                             color: Warna.hitam,
//                                             fontWeight: FontWeight.w500, // Medium
//                                           ),
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Text(
//                                           'Jumlah barang: ${data['quantity']}',
//                                           style: TextStyle(
//                                             color: Warna.card,
//                                             fontSize: 13,
//                                             fontWeight: FontWeight.w400, // Normal
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             if (currentData.length > 1 && index != currentData.length - 1)
//                               Container(
//                                 width: 350, // Set the desired width here
//                                 child: const Divider(), //buat list dividernya kalo rekapan lebih dari satu hari itu
//                               ),
//                           ],
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       }
//     });
//   }
// }
