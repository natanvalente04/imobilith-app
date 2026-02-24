import 'package:alugueis_app/components/dialog/dialog_textfield_senha.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DialogTextfieldConfirmaSenha extends DialogTextfieldSenha {
  final TextEditingController controllerSenha;
  const DialogTextfieldConfirmaSenha({
    super.key,
    required super.controller,
    required this.controllerSenha,
    required super.labelText,
    super.obrigatorio,
    super.enabled,
    super.focusNode
  });

  @override
  State<DialogTextfieldConfirmaSenha> createState() => _DialogTextfieldConfirmaSenhaState();
}

class _DialogTextfieldConfirmaSenhaState extends State<DialogTextfieldConfirmaSenha> {
  @override
  Widget build(BuildContext context) {
    return DialogTextfieldSenha(
      controller: widget.controller, 
      labelText: widget.labelText,
      obrigatorio: widget.obrigatorio,
      validator: (value){
        if (widget.obrigatorio && (value == null || value.trim().isEmpty)) {
          return 'Campo Obrigatório!';
        }
        if(value != widget.controllerSenha.text){
          return 'As senhas não coincidem';
        }
        return null;
      }
    );
  }
}