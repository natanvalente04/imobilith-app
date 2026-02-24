import 'package:alugueis_app/models/locacao.dart';

class LocacaoState {
  final List<Locacao> locacoesAtivas;
  final List<Locacao> locacoes;
  final Locacao locacao;
  final String result;

  LocacaoState({
    required this.locacoesAtivas,
    required this.locacoes,
    required this.locacao,
    required this.result,
  });

  factory LocacaoState.init(){
    return LocacaoState(locacoesAtivas: [], locacoes: [], locacao: Locacao.init(), result: '');
  }

  LocacaoState copyWith({
    List<Locacao>? locacoesAtivas,
    List<Locacao>? locacoes,
    Locacao? locacao,
    String? result,
  }
  ){
    return LocacaoState(
    locacoesAtivas: locacoesAtivas ?? this.locacoesAtivas,
    locacoes: locacoes ?? this.locacoes,
    locacao: locacao ?? this.locacao,
    result: result ?? this.result,
    );
  }
}