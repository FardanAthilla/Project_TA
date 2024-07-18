import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  final String itemName;
  final int quantity;
  final double price;
  final String categoryMachineName;
  final String? category;
  // final DateTime date; 

  DetailPage({
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.categoryMachineName,
    this.category,
    // required this.date, // Initialize the date
  });

  @override
  Widget build(BuildContext context) {
    // String formattedDate = DateFormat('EEEE, d MMMM y', 'id_ID').format(date); 

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detail Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Category Machine: $categoryMachineName',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Item Name: $itemName',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Quantity: $quantity',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Price: Rp $price',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              if (category != null)
                Text(
                  'Category: $category',
                  style: TextStyle(fontSize: 16),
                ),
              SizedBox(height: 10),
              // Text( 
              //   'Date: $formattedDate',
              //   style: TextStyle(fontSize: 16),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
