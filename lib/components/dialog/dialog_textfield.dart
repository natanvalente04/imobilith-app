import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogTextfield extends StatelessWidget{
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  const DialogTextfield({super.key, required this.controller, required this.labelText, this.keyboardType = TextInputType.text, this.inputFormatters, this.enabled = true});
  
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      enabled: enabled,
    );
  }
}