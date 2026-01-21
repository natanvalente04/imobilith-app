
import 'package:alugueis_app/components/datagrid/datagrid_delete_button.dart';
import 'package:alugueis_app/components/datagrid/datagrid_edit_button.dart';
import 'package:alugueis_app/components/tipo_despesa/cad_tipo_despesa_dialog.dart';
import 'package:alugueis_app/store/tipo_despesa_store.dart';
import 'package:flutter/material.dart';

class TiposDespesaList extends StatefulWidget {
  final TipoDespesaStore store;
  const TiposDespesaList({super.key, required this.store});

  @override
  State<TiposDespesaList> createState() => _TipoDespesaListState();
}

class _TipoDespesaListState extends State<TiposDespesaList>{

  void initState(){
    super.initState();
    widget.store.getTiposDespesa();
  }

  void _listener(){
    setState(() {
      
    });
  }

  void dispose(){
    widget.store.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return ValueListenableBuilder(
      valueListenable: widget.store,
      builder: (context, state, _){
        return Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 30,
                headingRowColor: WidgetStateProperty.all(Colors.grey[200]),
                columns: const [
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('Codigo')),
                  DataColumn(label: Text('Nome Tipo Despesa')),
                  DataColumn(label: Text('Compartilhado'))
                ],
                rows: state.tiposDespesa.map((tipoDespesa) {
                  return DataRow(
                    cells: [
                      DataCell(SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DatagridEditButton(
                                onPressed: (){
                                  showDialog(
                                    context: context,
                                    builder: (_) => CadTipoDespesaDialog(store: widget.store, tipoDespesa: tipoDespesa,)
                                  );
                                },
                              ),
                              const SizedBox(width: 16),
                              DatagridDeleteButton(
                                onPressed: (){
                                  widget.store.deleteTipoDespesa(tipoDespesa.codTipoDespesa);
                                },
                              )
                            ],
                          ),
                      )
                      ),
                      DataCell(Text(tipoDespesa.codTipoDespesa.toString())),
                      DataCell(Text(tipoDespesa.nomeTipoDespesa)),
                      DataCell(Text(tipoDespesa.compartilhado == 1 ? 'Sim' : 'Não'))
                    ]
                  );  
                }).toList(),
              ),
            )
          )
        );
      }
    );
  }
}