import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Card(
            child: ListTile(
              title: Container(
                width: double.infinity,
                height: 16.0,
                color: Colors.white,
              ),
              trailing: Container(
                width: 40.0,
                height: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}