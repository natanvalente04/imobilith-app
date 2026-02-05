import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogTextfield extends StatefulWidget{
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final bool obrigatorio;
  const DialogTextfield({super.key, 
    required this.controller, 
    required this.labelText, 
    this.keyboardType = TextInputType.text, 
    this.inputFormatters, 
    this.enabled = true, 
    this.obrigatorio = false
  });

  @override
  State<DialogTextfield> createState() => _DialogTextfieldState();
}

class _DialogTextfieldState extends State<DialogTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(labelText: widget.labelText + (widget.obrigatorio ? "*" : "")),
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      validator: (value) {
        if (widget.obrigatorio && (value == null || value.trim().isEmpty)) {
          return 'Campo Obrigatório!';
        }
      },
    );
  }
}