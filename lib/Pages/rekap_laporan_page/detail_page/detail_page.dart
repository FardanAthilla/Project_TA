import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String itemName;

  DetailPage({required this.itemName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Center(
        child: Text('Detail of $itemName'),
      ),
    );
  }
}
