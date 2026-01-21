import 'package:alugueis_app/components/dialog/dialog_dropdown.dart';
import 'package:alugueis_app/components/dialog/dialog_title.dart';
import 'package:alugueis_app/helper.dart';
import 'package:alugueis_app/models/despesa.dart';
import 'package:alugueis_app/store/apto_store.dart';
import 'package:alugueis_app/store/despesa_store.dart';
import 'package:alugueis_app/store/tipo_despesa_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CadDespesaDialog extends StatefulWidget {
  final DespesaStore store;
  final TipoDespesaStore tipoDespesaStore;
  final AptoStore aptoStore;
  final Despesa? despesa;
  const CadDespesaDialog({super.key, required this.store, required this.tipoDespesaStore, this.despesa, required this.aptoStore});

  @override
  State<CadDespesaDialog> createState() => _CadDespesaDialogState();
}

class _CadDespesaDialogState extends State<CadDespesaDialog> {
  final codDespesaController = TextEditingController();
  final vlrTotalDespesaController = TextEditingController();
  final dataDespesaController = TextEditingController();
  final competenciaMesController = TextEditingController();
  final codAptoControler = TextEditingController();
  int codTipoDespesa = 0;
  int? tipoDespesaSelecionado;
  int? aptoSelecionado;
  bool compartilhado = true;
  bool existe = false;

  @override
  void initState(){
    super.initState();
    codDespesaController.text = widget.despesa?.codDespesa.toString() ?? "";
    tipoDespesaSelecionado = widget.despesa?.codTipoDespesa ?? null;
    codTipoDespesa = tipoDespesaSelecionado ?? 0;
    aptoSelecionado = widget.despesa?.codApto ?? null;
    vlrTotalDespesaController.text = widget.despesa?.vlrTotalDespesa.toString() ?? "";
    dataDespesaController.text = Helper.formatDate(widget.despesa?.dataDespesa ?? DateTime.now()).toString();
    competenciaMesController.text = Helper.formatDateTime(widget.despesa?.competenciaMes ?? DateTime.now(), formato: 'MM/yyyy').toString();
    if(widget.despesa != null){
      existe = true;
    }
    widget.tipoDespesaStore.getTiposDespesa();
    widget.aptoStore.getAptos();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: DialogTitle(title: "Cadastrar despesa"),
      content: SizedBox(
        width: 750,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: codDespesaController,
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: "Código da Despesa*",
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: dataDespesaController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: "Data da Despesa*",
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: widget.tipoDespesaStore,
                      builder: (context, state, _) {
                        return DropdownButtonFormField<int>(
                          value: tipoDespesaSelecionado,
                          items: state.tiposDespesa.map((tipo) {
                            return DropdownMenuItem(
                              value: tipo.codTipoDespesa,
                              child: Text(tipo.nomeTipoDespesa),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              tipoDespesaSelecionado = value;
                              codTipoDespesa = tipoDespesaSelecionado ?? 0;
                              compartilhado = state.tiposDespesa
                                      .firstWhere((t) => t.codTipoDespesa == value)
                                      .compartilhado == 1;
                            });
                          },
                          decoration: const InputDecoration(labelText: "Tipo de Despesa*"),
                        );
                      }
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              if (!compartilhado)
                Row(
                  children: [
                    Expanded(
                      child: DialogDropdown(
                        store: widget.aptoStore,
                        value: aptoSelecionado,
                        onChanged: (value) {
                          setState(() {
                            aptoSelecionado = value;
                          });
                        },
                        label: "Apartamento",
                        itemsBuilder: (state) {
                          return state.aptos.map<DropdownMenuItem<int>>((a) {
                            return DropdownMenuItem(
                              value: a.codApto,
                              child: Text('Apto ${a.codApto}'),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: vlrTotalDespesaController,
                      decoration: const InputDecoration(
                        labelText: "Valor Total*",
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                      ],
                      onChanged: (value) {
                        if (value.contains(',')) {
                          final newValue = value.replaceAll(',', '.');
                          // Atualiza o texto e mantém o cursor no final
                          vlrTotalDespesaController.value = TextEditingValue(
                            text: newValue,
                            selection: TextSelection.collapsed(offset: newValue.length),
                          );
                        }
                      }
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: competenciaMesController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: "Competência (mês)*",
                      ),
                      onTap: () async {
                        final DateTime? selecionado = await showDatePicker(
                          context: context,
                          initialDate: DateTime(DateTime.now().year, DateTime.now().month, 10),
                          firstDate: DateTime(DateTime.now().year - 5),
                          lastDate: DateTime(DateTime.now().year + 100),
                        );
                        if (selecionado != null) {
                          setState(() {
                            competenciaMesController.text = Helper.formatDateTime(selecionado, formato: 'MM/yyyy');
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text("cancelar")
        ),
        ElevatedButton(
          onPressed: () {
            print('raw: "${dataDespesaController.text}"');
  print('trim: "${dataDespesaController.text.trim()}"');
print('runes: ${dataDespesaController.text.runes.toList()}');
print('codeUnits: ${dataDespesaController.text.codeUnits}');
            Despesa novaDespesa = Despesa(
              codDespesa: int.tryParse(codDespesaController.text) ?? 0,
              codTipoDespesa: codTipoDespesa,
              codApto: aptoSelecionado,
              vlrTotalDespesa: (double.tryParse(vlrTotalDespesaController.text.replaceAll(',', '.')) ?? 0 as num).toDouble(),
              dataDespesa: Helper.parseDateTime(dataDespesaController.text ),
              competenciaMes: Helper.parseDateTime("10/"+competenciaMesController.text)
            );
            existe ?
            widget.store.updateDespesa(novaDespesa)
            : widget.store.addDespesa(novaDespesa);
            Navigator.pop(context);
          },
          child: const Text("Salvar")
        )
      ],
    );
  }
}