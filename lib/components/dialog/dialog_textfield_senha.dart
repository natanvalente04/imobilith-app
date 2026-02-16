import 'package:alugueis_app/components/dialog/dialog_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogTextfieldSenha extends DialogTextfield {
  final bool? enabled;
  final bool obrigatorio;
  const DialogTextfieldSenha({super.key, 
    required super.controller, 
    required super.labelText, 
    super.keyboardType = TextInputType.text, 
    super.inputFormatters, 
    super.focusNode,
    super.onSubmitted,
    this.obrigatorio = true,
    this.enabled = true, 
  });

  @override
  State<DialogTextfieldSenha> createState() => _DialogTextfieldSenhaState();
}



class _DialogTextfieldSenhaState extends State<DialogTextfieldSenha> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        labelText: widget.labelText + (widget.obrigatorio ? "*" : ""), 
        suffixIcon: IconButton(
          icon: Icon(obscureText
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined
          ),
          onPressed: (){
            setState(() {
              obscureText = !obscureText;
            });
          } 
        ),
      ),
      
      keyboardType: widget.keyboardType,
      obscureText: obscureText,
      validator: (value) {
        if (widget.obrigatorio && (value == null || value.trim().isEmpty)) {
          return 'Campo Obrigatório!';
        }
      },
    );
  }
}