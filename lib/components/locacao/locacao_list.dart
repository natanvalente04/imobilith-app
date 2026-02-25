import 'package:alugueis_app/components/datagrid/datagrid_delete_button.dart';
import 'package:alugueis_app/components/datagrid/datagrid_edit_button.dart';
import 'package:alugueis_app/components/locacao/cad_locacao_dialog.dart';
import 'package:alugueis_app/components/locatario/locatario_detalha.dart';
import 'package:alugueis_app/store/apto_store.dart';
import 'package:alugueis_app/store/locacao_store.dart';
import 'package:alugueis_app/store/locatario_store.dart';
import 'package:flutter/material.dart';

class LocacaoList extends StatefulWidget {
  final LocacaoStore store;
  final AptoStore aptoStore;
  final LocatarioStore locatarioStore;
  const LocacaoList({super.key, required this.store, required this.aptoStore, required this.locatarioStore});

  @override
  State<LocacaoList> createState() => _LocacaoListState();
}

class _LocacaoListState extends State<LocacaoList> {

  void initState(){
    super.initState();
    widget.store.getLocacoesAtivas();
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
  Widget build(BuildContext context) {
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
                  DataColumn(label: Text('Código')),
                  DataColumn(label: Text('Apto')),
                  DataColumn(label: Text('Locatário')),
                ], 
                rows: state.locacoesAtivas.map((locacao){
                  return DataRow(
                    cells: [
                      DataCell(Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DatagridEditButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => CadLocacaoDialog(
                                  aptoStore: widget.aptoStore,
                                  locacaoStore: widget.store,
                                  locatarioStore: widget.locatarioStore,
                                  locacao: locacao,
                                )
                              );
                            },
                          ),
                          DatagridDeleteButton(
                            onPressed: () {
                              widget.store.deleteLocacao(locacao.codLocacao);
                            },
                          )
                        ],
                      )),
                      DataCell(Text(locacao.codLocacao.toString())),
                      DataCell(Text(locacao.codApto.toString())),
                      DataCell(
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => LocatarioDetalha(codLocatario: locacao.codLocatario),
                            );
                          },
                          child: Text(
                            locacao.nomeLocatario!,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ]
                  );
                }).toList(),
              ),
            ),
          ),
        );
      }
    );
  }
}