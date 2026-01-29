import 'package:alugueis_app/components/dialog/dialog_textfield.dart';
import 'package:alugueis_app/helper.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DialogTextfieldPhone extends DialogTextfield {
  final MaskTextInputFormatter inputFormatter = Helper.phoneMask;
  DialogTextfieldPhone({super.key, required super.controller, required super.labelText});

  @override
  State<DialogTextfieldPhone> createState() => _DialogTextfieldPhoneState();
}

class _DialogTextfieldPhoneState extends State<DialogTextfieldPhone> {
  @override
  Widget build(BuildContext context) {
    return DialogTextfield(
      controller: widget.controller,
      labelText: widget.labelText,
      keyboardType: TextInputType.number,
      inputFormatters: [widget.inputFormatter],                  
    );
  }
}