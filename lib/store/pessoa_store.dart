import 'package:alugueis_app/models/pessoa.dart';
import 'package:alugueis_app/repositories/pessoa_repository.dart';
import 'package:alugueis_app/states/pessoa_state.dart';
import 'package:flutter/cupertino.dart';

class PessoaStore extends ValueNotifier<PessoaState> {
  final repository = PessoaRepository();
  PessoaStore() : super(PessoaState.init());

  Future<void> getPessoas() async {
    final pessoas = await repository.getPessoas();
    value = value.copyWith(pessoas: pessoas);
  }

  Future<void> addPessoa(Pessoa pessoa) async {
    Pessoa pessoaNova = await repository.addPessoa(pessoa);
    value = value.copyWith(
      pessoas: [...value.pessoas, pessoaNova],
    );
  }

  Future<void> updatePessoa(Pessoa pessoaAtualizada) async {
    await repository.updatePessoa(pessoaAtualizada);
    getPessoas();
  }
}