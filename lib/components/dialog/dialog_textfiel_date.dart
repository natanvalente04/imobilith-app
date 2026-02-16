import 'package:alugueis_app/components/dialog/dialog_textfield.dart';
import 'package:alugueis_app/helper.dart';
import 'package:flutter/material.dart';

class DialogTextfielDate extends DialogTextfield {
  DialogTextfielDate({
    required super.controller, 
    required super.labelText, 
    super.obrigatorio,
    });
  
  @override
  State<DialogTextfielDate> createState() => _DialogTextFieldDateState();
}

class _DialogTextFieldDateState extends State<DialogTextfielDate> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText + (widget.obrigatorio ? "*" : ""), 
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_month_outlined),
          onPressed: () async {
            final DateTime? selecionado = await showDatePicker(
              context: context,
              firstDate: DateTime(DateTime.now().year - 150),
              lastDate: DateTime(DateTime.now().year + 1),
            );
            if (selecionado != null) {
                widget.controller.text = Helper.formatDate(selecionado);
            }
          } 
        ),
      ),
      onTap: () async {
        
      },
    );
  }
}