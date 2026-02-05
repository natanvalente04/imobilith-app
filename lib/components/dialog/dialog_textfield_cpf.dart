import 'dart:async';
import 'package:alugueis_app/components/dialog/dialog_textfield.dart';
import 'package:alugueis_app/helper.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DialogTextfieldCpf extends DialogTextfield {
  final MaskTextInputFormatter inputFormatter = Helper.cpfMask;
  DialogTextfieldCpf({super.key, required super.controller, super.labelText = "CPF"});

  @override
  State<DialogTextfieldCpf> createState() => _DialogTextfieldCpfState();
}

class _DialogTextfieldCpfState extends State<DialogTextfieldCpf>{
  @override
  Widget build(BuildContext context) {
    return DialogTextfield(
      controller: widget.controller,
      labelText: widget.labelText,
      keyboardType: TextInputType.number,
      inputFormatters: [widget.inputFormatter],
      obrigatorio: true,                  
    );
  } 
}