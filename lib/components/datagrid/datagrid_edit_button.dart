import 'package:flutter/material.dart';

class DatagridEditButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const DatagridEditButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      hoverColor: Colors.grey[300],
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(4),
          color: Colors.transparent
        ),
        child: Icon(Icons.edit),
      ),
    );
  }
}