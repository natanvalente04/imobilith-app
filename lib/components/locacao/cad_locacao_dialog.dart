import 'package:alugueis_app/components/dialog/dialog_dropdown_listenable.dart';
import 'package:alugueis_app/components/dialog/dialog_textfield.dart';
import 'package:alugueis_app/components/dialog/dialog_textfield_numeric.dart';
import 'package:alugueis_app/components/dialog/dialog_title.dart';
import 'package:alugueis_app/helper.dart';
import 'package:alugueis_app/models/locacao.dart';
import 'package:alugueis_app/store/apto_store.dart';
import 'package:alugueis_app/store/locacao_store.dart';
import 'package:alugueis_app/store/locatario_store.dart';
import 'package:flutter/material.dart';

class CadLocacaoDialog extends StatefulWidget {
  final LocacaoStore locacaoStore;
  final LocatarioStore locatarioStore;
  final AptoStore aptoStore;
  final Locacao? locacao;
  const CadLocacaoDialog({
    super.key, 
    required this.locacaoStore, 
    required this.locatarioStore, 
    required this.aptoStore, 
    this.locacao
  });

  @override
  State<CadLocacaoDialog> createState() => _CadLocacaoDialogState();
}

class _CadLocacaoDialogState extends State<CadLocacaoDialog> {
  final _formKey = GlobalKey<FormState>();
  final codLocacaoController = TextEditingController();
  final vlrAluguelController = TextEditingController();
  final vlrCausaoController = TextEditingController();
  final dataInicioController = TextEditingController();
  final dataFimController = TextEditingController();
  int? aptoSelecionado; 
  int? locatarioSelecionado;

  @override
  void initState(){
    super.initState();
    codLocacaoController.text = widget.locacao?.codLocacao.toString() ?? "";
    vlrAluguelController.text = widget.locacao?.vlrAluguel.toString() ?? "";
    vlrCausaoController.text = widget.locacao?.vlrCausao.toString() ?? "";
    dataInicioController.text = Helper.formatDate(widget.locacao?.dataInicio ?? DateTime.now()).toString();
    dataFimController.text = Helper.formatDate(widget.locacao?.dataFim ?? DateTime.now()).toString();
    aptoSelecionado = widget.locacao?.codApto;
    locatarioSelecionado = widget.locacao?.codLocatario;
    widget.aptoStore.getAptos();
    widget.locatarioStore.getLocatarios();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: DialogTitle(title: "Cadastrar Locação"),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SizedBox(
                        width: 60,
                        child: DialogTextfieldNumeric(controller: codLocacaoController, labelText: "Codigo", enabled: false),
                      ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DialogDropdownListenable(
                      store: widget.aptoStore,
                      value: aptoSelecionado,
                      obrigatorio: true,
                      onChanged: (value){
                        setState(() {
                          aptoSelecionado = value;
                        });
                      },
                      label: "Apartamento",
                      itemsBuilder: (State){
                        return State.aptos.map((apto) {
                          return DropdownMenuItem(
                            value: apto.codApto,
                            child: Text(apto.nomePredio! + ' - Apto: ' + apto.codApto.toString()),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16,),
              DialogDropdownListenable(
                store: widget.locatarioStore,
                value: locatarioSelecionado,
                obrigatorio: true,
                onChanged: (value){
                  setState(() {
                    locatarioSelecionado = value;
                  });
                },
                label: "Locatario",
                itemsBuilder: (State){
                  return State.locatarios.map((locatario) {
                    return DropdownMenuItem(
                      value: locatario.codLocatario,
                      child: Text(locatario.pessoa!.nomePessoa + ' ( ' + locatario.pessoa!.cpf + ' )'),
                    );
                  }).toList();
                },
              ),
              const SizedBox(height: 16),
            ],
          )
        ),
      )
    );
  }
}