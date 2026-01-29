import 'package:flutter/material.dart';

class DialogTitle extends StatelessWidget {
  final String title;
  final double fontSize;
  const DialogTitle({super.key, required this.title, this.fontSize = 15});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: fontSize),),
          IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close))
        ]
      );
  }
}