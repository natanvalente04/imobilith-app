import 'package:alugueis_app/components/dialog/dialog_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';

class DialogTextfieldNumeric extends DialogTextfield {

  const DialogTextfieldNumeric({super.key, required super.controller,required super.labelText, super.enabled=true});

  @override
  State<DialogTextfieldNumeric> createState() => _DialogTextfieldNumericState();
}

class _DialogTextfieldNumericState extends State<DialogTextfieldNumeric> {
  @override
  Widget build(BuildContext context) {
    return DialogTextfield(
      controller: widget.controller, 
      labelText: widget.labelText,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      enabled: widget.enabled,
    );
  }
}