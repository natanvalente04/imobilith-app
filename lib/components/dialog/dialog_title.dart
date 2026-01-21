import 'package:flutter/material.dart';

class DialogTitle extends StatelessWidget {
  final String title;
  const DialogTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close))
        ]
      );
  }
}