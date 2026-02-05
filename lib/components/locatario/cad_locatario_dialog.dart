import 'package:alugueis_app/components/dialog/dialog_textfield_numeric.dart';
import 'package:alugueis_app/components/dialog/dialog_title.dart';
import 'package:alugueis_app/models/locatario.dart';
import 'package:alugueis_app/store/locatario_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadLocatarioDialog extends StatefulWidget {
  final LocatarioStore store;
  final Locatario? locatario;
  final int? codPessoa;
  const CadLocatarioDialog({super.key, required this.store, this.locatario, this.codPessoa});



  @override
  State<CadLocatarioDialog> createState() => _CadLocatarioDialogState();

}



class _CadLocatarioDialogState extends State<CadLocatarioDialog> {
  final _formKey = GlobalKey<FormState>();
    final dependentesController = TextEditingController();
    int? temPet;
    bool existe = false;

    @override
    void initState() {
      super.initState();

    }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: DialogTitle(title: "Cadastrar Locatario"),
      content: SizedBox(
        width: 120,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DialogTextfieldNumeric(
                controller: dependentesController,
                labelText: "Quantidade de dependentes",
                obrigatorio: true
              ),
              const SizedBox(width: 16),
              DropdownButtonFormField(
                value: temPet,
                decoration: const InputDecoration(
                  labelText: "Possui pet?*",
                ),
                items: const [
                  DropdownMenuItem(value: 1, child: Text("Sim")),
                  DropdownMenuItem(value: 0, child: Text("Não"))
                ],
                onChanged: (value){
                  setState((){
                    temPet = value;
                  });
                }
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
            return;
          }
            Locatario novoLocatario = Locatario(
              codLocatario: 0,
              codPessoa: widget.codPessoa ?? 0,
              qtdDependentes: int.tryParse(dependentesController.text) ?? 0,
              temPet: temPet ?? 0,
            );
            existe ? 
            widget.store.updateLocatario(novoLocatario)
            : widget.store.addLocatario(novoLocatario);
            Navigator.pop(context);
          },
          child: const Text("Salvar"),
        ),
      ],
    );
  }
}