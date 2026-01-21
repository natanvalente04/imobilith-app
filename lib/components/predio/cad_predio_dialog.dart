import 'package:alugueis_app/components/dialog/dialog_title.dart';
import 'package:alugueis_app/models/predio.dart';
import 'package:alugueis_app/store/predio_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CadPredioDialog extends StatefulWidget {
  final PredioStore store;
  final Predio? predio;
  const CadPredioDialog({super.key, required this.store, this.predio});

  @override
  State<CadPredioDialog> createState() => _CAdPredioDialogState();
}

class _CAdPredioDialogState extends State<CadPredioDialog> {
  final codPredioController = TextEditingController();
  final nomePredioController = TextEditingController();
  final enderecoController = TextEditingController();
  final qtdAndaresController = TextEditingController();
  bool existe = false;
  @override
  void initState(){
    super.initState();
    codPredioController.text = widget.predio?.codPredio.toString() ?? "";
    nomePredioController.text = widget.predio?.nomePredio ?? "";
    enderecoController.text = widget.predio?.endereco ?? "";
    qtdAndaresController.text = widget.predio?.qtdAndares.toString() ?? "";
    existe = widget.predio == null ? false : true;
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: DialogTitle(title: 'Cadastrar Predio'),
      content: SizedBox(
        width: 650,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 60,
                  child: TextField(
                    controller: codPredioController,
                    decoration: InputDecoration(labelText: "codigo"),
                    keyboardType: TextInputType.number,
                    enabled: false,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: nomePredioController,
                    decoration: InputDecoration(labelText: "nome*"),
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: qtdAndaresController,
                    decoration: InputDecoration(labelText: "qtd andares*"),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: enderecoController,
              decoration: InputDecoration(labelText: "endereço*"),
              keyboardType: TextInputType.text,
            ),
          ],
        )
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text("cancelar")
        ),
        ElevatedButton(
          onPressed: (){
            Predio novoPredio = Predio(
              codPredio: int.tryParse(codPredioController.text) ?? 0,
              nomePredio: nomePredioController.text,
              qtdAndares: int.tryParse(qtdAndaresController.text) ?? 0,
              endereco: enderecoController.text
            );
            existe ? 
            widget.store.updatePredio(novoPredio)
            : widget.store.addPredio(novoPredio);
            Navigator.pop(context);
          }, 
          child: Text("salvar")
        )
      ],
    );
  }
}