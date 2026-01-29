import 'package:alugueis_app/components/usuario/cad_usuario_dialog.dart';
import 'package:alugueis_app/components/usuario/usuario_list.dart';
import 'package:alugueis_app/store/pessoa_store.dart';
import 'package:alugueis_app/store/usuario_store.dart';
import 'package:flutter/material.dart';

class UsuarioPage extends StatelessWidget {
  final store = UsuarioStore();
  final pessoaStore = PessoaStore();
  UsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Usuários'),
      ),
      body: Container(
        child: Column(
          children: [
            UsuarioList(store: store, pessoaStore: pessoaStore),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (_) => CadUsuarioDialog(store: store, pessoaStore: pessoaStore),
          );
        },
        child: const Icon(Icons.add)
      )
    );
  }
}