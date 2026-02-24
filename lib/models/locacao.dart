import 'package:alugueis_app/repositories/helper/json_serializable.dart';
import 'package:equatable/equatable.dart';

class Locacao extends Equatable implements JsonSerializable{
  final int codLocacao;
  final int codApto;
  final int codLocatario;
  final double vlrAluguel;
  final double vlrCausao;
  final DateTime dataInicio;
  final DateTime dataFim;
  const Locacao({
    required this.codLocacao,
    required this.codApto,
    required this.codLocatario,
    required this.vlrAluguel,
    required this.vlrCausao,
    required this.dataInicio,
    required this.dataFim,
  });

  @override
  List<Object?> get props => [
    codLocacao,
    codApto, 
    codLocatario, 
    vlrAluguel,
    vlrCausao,
    dataInicio,
    dataFim
  ];

  factory Locacao.init(){
    return Locacao(
      codLocacao: 0,
      codApto: 0,
      codLocatario: 0,
      vlrAluguel: 0.0,
      vlrCausao: 0.0,
      dataInicio: DateTime.now(),
      dataFim: DateTime.now()
    );
  }

  factory Locacao.fromJson(Map<String, dynamic> json){
    return Locacao(
      codLocacao: json['codLocacao'],
      codApto: json['codApto'],
      codLocatario: json['codLocatario'],
      vlrAluguel: (json['vlrAluguel'] as num).toDouble(),
      vlrCausao: (json['vlrCausao'] as num).toDouble(),
      dataInicio: DateTime.parse(json['dataInicio']),
      dataFim: DateTime.parse(json['dataFim']),
    );
  }
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'codLocacao': codLocacao,
      'codApto': codApto, 
      'codLocatario': codLocatario, 
      'vlrAluguel': vlrAluguel,
      'vlrCausao': vlrCausao,
      'dataInicio': dataInicio.toIso8601String(),
      'dataFim': dataFim.toIso8601String()
    };
  }
}