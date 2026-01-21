import 'package:alugueis_app/components/datagrid/datagrid_delete_button.dart';
import 'package:alugueis_app/components/datagrid/datagrid_edit_button.dart';
import 'package:alugueis_app/components/apto/cad_apto_dialog.dart';
import 'package:alugueis_app/store/apto_store.dart';
import 'package:alugueis_app/store/predio_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AptoList extends StatefulWidget {
  final AptoStore store;
  final PredioStore predioStore;
  const AptoList({super.key, required this.store, required this.predioStore});

  @override
  State<AptoList> createState() => _AptoListState();
}

class _AptoListState extends State<AptoList> {

  void initState(){
    super.initState();
    widget.store.getAptos();
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
                  DataColumn(label: Text('Codigo')),
                  DataColumn(label: Text('Codigo Predio')),
                  DataColumn(label: Text('Andar')),
                  DataColumn(label: Text('Quantidade Quartos')),
                  DataColumn(label: Text('Quantidade Banheiros')),
                  DataColumn(label: Text('Metros Quadrados'))
                ],
                rows: state.aptos.map((apto) {
                  return DataRow(
                    cells: [
                      DataCell(Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DatagridEditButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => CadAptoDialog(store: widget.store,
                                                              apto: apto, 
                                                              predioStore: widget.predioStore,
                                                              )
                              );
                            },
                          ),
                          DatagridDeleteButton(
                            onPressed: () {
                              widget.store.deleteApto(apto.codApto);
                            },
                          )
                        ],
                      )),
                      DataCell(Text(apto.codApto.toString())),
                      DataCell(Text(apto.codPredio.toString() + ' - ' + apto.nomePredio.toString())),
                      DataCell(Text(apto.andar.toString())),
                      DataCell(Text(apto.qtdBanheiros.toString())),
                      DataCell(Text(apto.qtdQuartos.toString())),
                      DataCell(Text(apto.metrosQuadrados.toString())),
                    ]
                  );
                }).toList(),
              )
            )
          )
        );
      }
    );
  }
}