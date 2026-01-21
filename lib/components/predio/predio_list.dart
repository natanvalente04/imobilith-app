import 'package:alugueis_app/components/datagrid/datagrid_delete_button.dart';
import 'package:alugueis_app/components/datagrid/datagrid_edit_button.dart';
import 'package:alugueis_app/components/predio/cad_predio_dialog.dart';
import 'package:alugueis_app/store/predio_store.dart';
import 'package:flutter/material.dart';

class PredioList extends StatefulWidget {
  final PredioStore store;
  const PredioList({super.key, required this.store});

  @override
  State<PredioList> createState() => _PredioListState();
}

class _PredioListState extends State<PredioList> {

  void initState(){
    super.initState();
    widget.store.addListener(_listener);

    WidgetsBinding.instance.addPostFrameCallback((_){
      widget.store.getPredios();
    });
  }

  void _listener() {
    setState(() {
      
    });
  }

  void dispose() {
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
                columns: const[
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('Código')),
                  DataColumn(label: Text('Nome')),
                  DataColumn(label: Text('Endereço')),
                  DataColumn(label: Text('Quantidade Andares'))
                ],
                rows: state.predios.map((predio){
                  return DataRow(
                    cells: [
                      DataCell(Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DatagridEditButton(
                            onPressed: (){
                              showDialog(
                                context: context, 
                                builder: (_) => CadPredioDialog(store: widget.store, predio: predio,)
                              ); 
                            },
                          ),
                          DatagridDeleteButton(
                            onPressed: (){
                              widget.store.deletePredio(predio.codPredio);
                            },
                          ),
                        ],
                      )),
                      DataCell(Text(predio.codPredio.toString())),
                      DataCell(Text(predio.nomePredio)),
                      DataCell(Text(predio.endereco)),
                      DataCell(Text(predio.qtdAndares.toString()))
                    ]
                  );
                }).toList()
              )
            )
          ),
        );
      }
    );
  }
}