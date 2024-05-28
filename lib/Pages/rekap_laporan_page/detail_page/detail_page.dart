import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String itemName;
  final int quantity;
  final double price;
  // final String categoryMachineName;


  DetailPage({
    required this.itemName,
    required this.quantity,
    required this.price,
    // required this.categoryMachineName
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category Machine: ',

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
          ],
        ),
      ),
    );
  }
}
