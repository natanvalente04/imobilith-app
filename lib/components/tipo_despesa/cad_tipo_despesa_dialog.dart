import 'package:alugueis_app/components/dialog/dialog_title.dart';
import 'package:alugueis_app/models/tipo_despesa.dart';
import 'package:alugueis_app/store/tipo_despesa_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class CadTipoDespesaDialog extends StatefulWidget {
  final TipoDespesaStore store;
  final TipoDespesa? tipoDespesa;
  const CadTipoDespesaDialog({super.key, required this.store, this.tipoDespesa});

  @override
  State<CadTipoDespesaDialog> createState() => _CadTipoDespesaDialogState();
}

class _CadTipoDespesaDialogState extends State<CadTipoDespesaDialog> {
  final codTipoController = TextEditingController();
  final nomeTipoController = TextEditingController();
  int? selecionado;
  bool existe = false;

  @override
  void initState(){
    super.initState();
    codTipoController.text = widget.tipoDespesa?.codTipoDespesa.toString() ?? "";
    nomeTipoController.text = widget.tipoDespesa?.nomeTipoDespesa ?? "";
    selecionado = widget.tipoDespesa?.compartilhado ?? null;
    if(widget.tipoDespesa != null){
      existe = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: DialogTitle(title: "Cadastrar Tipo de Despesa"),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: codTipoController,
              decoration: InputDecoration(labelText: "Codigo"),
              enabled: false,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nomeTipoController,
              decoration: InputDecoration(labelText: "Descrição"),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: selecionado,
              decoration: const InputDecoration(
                labelText: "Compartilhado?",
                border: OutlineInputBorder()
              ),
              items: const[
                DropdownMenuItem(value: 1, child: Text("Sim")),
                DropdownMenuItem(value: 0, child: Text("Não")),
              ], 
              onChanged: (value){
                setState(() {
                  selecionado = value;
                });
              }
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: const Text("Cancelar")
        ),
        ElevatedButton(onPressed: () {
          TipoDespesa novoTipoDespesa = TipoDespesa(
            codTipoDespesa: int.tryParse(codTipoController.text) ?? 0, 
            nomeTipoDespesa: nomeTipoController.text, 
            compartilhado: selecionado ?? 0,
          );
          existe ? 
          widget.store.updateTipoDespesa(novoTipoDespesa)
          : widget.store.addTipoDespesa(novoTipoDespesa);
          Navigator.pop(context);
        }, 
        child: const Text("Salvar"),
        )
      ],
    );
  }
}