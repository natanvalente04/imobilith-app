import 'package:alugueis_app/components/datagrid/datagrid_delete_button.dart';
import 'package:alugueis_app/components/datagrid/datagrid_edit_button.dart';
import 'package:alugueis_app/components/usuario/cad_usuario_dialog.dart';
import 'package:alugueis_app/models/usuario.dart';
import 'package:alugueis_app/store/locatario_store.dart';
import 'package:alugueis_app/store/pessoa_store.dart';
import 'package:alugueis_app/store/usuario_store.dart';
import 'package:flutter/material.dart';

class UsuarioList extends StatefulWidget {
  final UsuarioStore store;
  final PessoaStore pessoaStore;
  final LocatarioStore locatarioStore;
  const UsuarioList({super.key, required this.store, required this.pessoaStore, required this.locatarioStore});

  @override
  State<UsuarioList> createState() => _UsuarioListState();
}

class _UsuarioListState extends State<UsuarioList> {

  void initState(){
    super.initState();
    widget.store.getUsuarios();
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
                headingRowColor: WidgetStateProperty.all(Colors.grey[200]),
                columns: const [
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('Código')),
                  DataColumn(label: Text('Código Pessoa')),
                  DataColumn(label: Text('Tipo')),
                  DataColumn(label: Text('Situação')),
                ], 
                rows: state.usuarios.map((usuario) {
                  return DataRow(
                    cells: [
                      DataCell(
                        SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DatagridEditButton(
                                onPressed: (){
                                  showDialog(
                                    context: context,
                                    builder: (_) => CadUsuarioDialog(store: widget.store, pessoaStore: widget.pessoaStore, usuario: usuario, locatarioStore: widget.locatarioStore,)
                                  );
                                },
                              ),
                              const SizedBox(width: 16),
                              DatagridDeleteButton(
                                onPressed: (){
                                  widget.store.deleteUsuario(usuario.codUsuario);
                                },
                              )
                            ],
                          ),
                        )
                      ),
                      DataCell(Text(usuario.codUsuario.toString())),
                      DataCell(Text(usuario.codPessoa.toString())),
                      DataCell(Text(usuario.role.label)),
                      DataCell(Text(usuario.ativo == true ? 'Ativo' : 'Inativo')),
                    ]
                  );
                }).toList(),
              ),
            ),
          )
        );
      }
    );
  }
}