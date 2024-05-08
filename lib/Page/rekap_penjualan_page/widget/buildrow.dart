import 'package:flutter/material.dart';

class BuildRow extends StatelessWidget {
  final String label;
  final String text;

  const BuildRow({Key? key, required this.label, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        SizedBox(width: 8), 
        Expanded(
          flex: 3,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
