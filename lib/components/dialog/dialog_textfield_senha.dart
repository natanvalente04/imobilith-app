import 'package:alugueis_app/components/dialog/dialog_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogTextfieldSenha extends DialogTextfield {
  final bool? enabled;
  const DialogTextfieldSenha({super.key, 
    required super.controller, 
    required super.labelText, 
    super.keyboardType = TextInputType.text, 
    super.inputFormatters, 
    this.enabled = true, 
  });

  @override
  State<DialogTextfieldSenha> createState() => _DialogTextfieldSenhaState();
}



class _DialogTextfieldSenhaState extends State<DialogTextfieldSenha> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText, 
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
    );
  }
}