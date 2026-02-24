import 'package:alugueis_app/components/dialog/dialog_textfield.dart';
import 'package:alugueis_app/helper.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DialogTextfieldDate extends DialogTextfield {
  final MaskTextInputFormatter inputFormatter;
  final bool isBirthDate;
  final String formato;
  DialogTextfieldDate({
    required super.controller, 
    required super.labelText,
    super.enabled = true,
    super.obrigatorio,
    this.isBirthDate = false,
    required this.inputFormatter,
    this.formato = "dd/MM/yyyy"
  });
  
  @override
  State<DialogTextfieldDate> createState() => _DialogTextFieldDateState();
}

class _DialogTextFieldDateState extends State<DialogTextfieldDate> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      inputFormatters: [widget.inputFormatter],
      enabled: widget.enabled,
      decoration: InputDecoration(
        labelText: widget.labelText + (widget.obrigatorio ? "*" : ""), 
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_month_outlined),
          onPressed: () async {
            final DateTime? selecionado = await showDatePicker(
              context: context,
              firstDate: DateTime(DateTime.now().year - 150),
              lastDate: DateTime(DateTime.now().year + 150),
            );
            if (selecionado != null) {
                widget.controller.text = Helper.formatDate(selecionado, formato: widget.formato);
            }
          } 
        ),
      ),
      validator: (value) {
        if (widget.obrigatorio && (value == null || value.trim().isEmpty)) {
          return 'Campo Obrigatório!';
        }
        if(!Helper.validaDataBR(value!, formato: widget.formato)){
          return 'Data Inválida!';
        }
        if(widget.isBirthDate && !Helper.validaDataNascimento(value)){
          return 'Data Nascimento Inválida!';
        }
      },
    );
  }
}