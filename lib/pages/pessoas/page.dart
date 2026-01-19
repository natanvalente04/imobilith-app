import 'package:alugueis_app/components/pessoa/cad_pessoa_dialog.dart';
import 'package:alugueis_app/components/pessoa/pessoa_list.dart';
import 'package:alugueis_app/store/pessoa_store.dart';
import 'package:flutter/material.dart';

class PessoaPage extends StatelessWidget {
  final store = PessoaStore();

  PessoaPage({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Pessoas'),
      ),
      body: Container(
        child: Column(
          children: [
            PessoaList(store: store)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context, 
            builder: (_) => CadPessoaDialog(store: store),
          );
        },
        child: const Icon(Icons.add)
      ),
    );
  }
}