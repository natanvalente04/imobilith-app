import 'package:alugueis_app/components/locacao/cad_locacao_dialog.dart';
import 'package:alugueis_app/components/locatario/locatario_detalha.dart';
import 'package:alugueis_app/store/apto_store.dart';
import 'package:alugueis_app/store/locacao_store.dart';
import 'package:alugueis_app/store/locatario_store.dart';
import 'package:flutter/material.dart';

class LocacaoPage extends StatelessWidget {
  final store = LocacaoStore();
  final aptoStore = AptoStore();
  final locatarioStore = LocatarioStore();
  LocacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locações'),
      ),
      body: Container(
        child: Column(
          children: [
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => CadLocacaoDialog(
              aptoStore: aptoStore,
              locacaoStore: store,
              locatarioStore: locatarioStore,
            )
          );
        },
        child: Icon(Icons.add)
      ),
    );
  }
}