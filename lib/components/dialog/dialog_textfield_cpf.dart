import 'dart:async';
import 'package:alugueis_app/components/dialog/dialog_textfield.dart';
import 'package:alugueis_app/helper.dart';
import 'package:flutter/material.dart';

class DialogTextfieldCpf extends DialogTextfield {
  const DialogTextfieldCpf({super.key, required super.controller, super.labelText = "CPF*"});

  @override
  Widget build(BuildContext context) {
    return DialogTextfield(
      controller: controller,
      labelText: labelText,
      keyboardType: TextInputType.number,
      inputFormatters: [
        Helper.cpfMask
      ],                  
    );
  }
}