import 'package:alugueis_app/models/locacao.dart';
import 'package:alugueis_app/repositories/locacao_repository.dart';
import 'package:alugueis_app/states/locacao_state.dart';
import 'package:flutter/material.dart';

class LocacaoStore extends ValueNotifier<LocacaoState>{
  final repository = LocacaoRepository();
  LocacaoStore() : super(LocacaoState.init());

  Future<void> getLocacoes() async {
    final locacoes = await repository.getLocacoes();
    value = value.copyWith(locacoes: locacoes);
  }

  Future<void> getLocacoesAtivas() async {
    final locacoesAtivas = await repository.getLocacoesAtivas();
    value = value.copyWith(locacoesAtivas: locacoesAtivas);
  }

  Future<void> addLocacao(Locacao locacao) async {
    final locacaoNovo = await repository.addLocacao(locacao);
    value = value.copyWith(
      locacoesAtivas: [...value.locacoesAtivas, locacaoNovo]
    );
  }

  Future<void> deleteLocacao(int codLocacao) async {
    await repository.deleteLocacao(codLocacao);
    getLocacoesAtivas();
  }

  Future<void> updateLocacao(Locacao locacaoAtualizado) async {
    await repository.updateLocacao(locacaoAtualizado);
    getLocacoesAtivas();
  }
}