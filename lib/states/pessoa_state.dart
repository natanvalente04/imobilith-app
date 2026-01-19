import 'package:alugueis_app/models/pessoa.dart';

class PessoaState {
  final List<Pessoa> pessoas;
  final Pessoa pessoa;
  final String result;

  PessoaState({
    required this.pessoas,
    required this.pessoa, 
    required this.result
  });

  factory PessoaState.init(){
    return PessoaState(pessoas: [], pessoa: Pessoa.init(), result: '');
  }

  PessoaState copyWith({
    List<Pessoa>? pessoas,
    Pessoa? pessoa,
    String? result,
  })
  {
    return PessoaState(
      pessoas: pessoas ?? this.pessoas,
      pessoa: pessoa ?? this.pessoa,
      result: result ?? this.result,  
    );
  }
}