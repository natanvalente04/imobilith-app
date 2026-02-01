import 'package:alugueis_app/components/datagrid/datagrid_delete_button.dart';
import 'package:alugueis_app/components/datagrid/datagrid_edit_button.dart';
import 'package:alugueis_app/components/locatario/cad_locatario_dialog.dart';
import 'package:alugueis_app/components/pessoa/cad_pessoa_dialog.dart';
import 'package:alugueis_app/helper.dart';
import 'package:alugueis_app/models/pessoa.dart';
import 'package:alugueis_app/store/locatario_store.dart';
import 'package:alugueis_app/store/pessoa_store.dart';
import 'package:flutter/material.dart';

class PessoaList extends StatefulWidget {
  final PessoaStore store;
  const PessoaList({super.key, required this.store});

  @override
  State<PessoaList> createState() => _PessoaListState();
}

class _PessoaListState extends State<PessoaList> {
  final LocatarioStore locatarioStore = LocatarioStore();
  bool ehLocatario = false;
  void initState(){
    super.initState();
    widget.store.addListener(_listener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.store.getPessoas();
    });
  }

  void _listener() {
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
      builder: (context, state, _) {
        return Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 30,
                headingRowColor: WidgetStateProperty.all(Colors.grey[200]),
                columns: const[
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('Codigo')),
                  DataColumn(label: Text('Nome')),
                  DataColumn(label: Text('cpf')),
                  DataColumn(label: Text('rg')),
                  DataColumn(label: Text('endereco')),
                  DataColumn(label: Text('telefone')),
                  DataColumn(label: Text('email')),
                  DataColumn(label: Text('estado civil')),
                  DataColumn(label: Text('idade')),
                  DataColumn(label: Text('Locatário'))
                ], 
                rows: state.pessoas.map((p) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DatagridEditButton(
                              onPressed: () {
                                showDialog(
                                  context: context, 
                                  builder: (_) => CadPessoaDialog(store: widget.store, pessoa: p,));
                              },
                            ),
                            DatagridDeleteButton(
                              onPressed: () {
                                
                              },
                            ),
                          ],
                        )
                      ),
                      DataCell(Text(p.codPessoa.toString())),
                      DataCell(Text(p.nomePessoa.toString())),
                      DataCell(Text(p.cpf.toString())),
                      DataCell(Text(p.rg.toString())),
                      DataCell(Text(p.endereco.toString())),
                      DataCell(Text(p.telefone.toString())),
                      DataCell(Text(p.email.toString())),
                      DataCell(Text(p.estadoCivil.label)),
                      DataCell(Text(Helper.calcularIdade(p.dataNascimento).toString())),
                      DataCell(
                        Checkbox(
                          value: ehLocatario,
                          onChanged: (value) {
                            if(value!){
                              showDialog(
                                context: context, 
                                builder: (_) => CadLocatarioDialog(store: locatarioStore, codPessoa: p.codPessoa,)
                              );
                            }
                            setState(() => ehLocatario = value);
                          },
                        )
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