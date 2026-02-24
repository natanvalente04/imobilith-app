// ignore_for_file: non_constant_identifier_names


import 'package:alugueis_app/repositories/helper/json_serializable.dart';
import 'package:equatable/equatable.dart';

class Despesa extends Equatable implements JsonSerializable{
  final int codDespesa;
  final int codTipoDespesa;
  final String? nomeTipoDespesa;
  final int? codApto;
  final double vlrTotalDespesa;
  final DateTime dataDespesa;
  final DateTime competenciaMes;
  final int? compartilhado;
  const Despesa({
    required this.codDespesa,
    required this.codTipoDespesa,
    this.nomeTipoDespesa,
    this.codApto,
    required this.vlrTotalDespesa,
    required this.dataDespesa,
    required this.competenciaMes,
    this.compartilhado
  });

  factory Despesa.fromJson(Map<String, dynamic> json){
    return Despesa(
      codDespesa: json['codDespesa'],
      codTipoDespesa: json['codTipoDespesa'],
      nomeTipoDespesa: json['nomeTipoDespesa'],
      codApto: json['codApto'],
      vlrTotalDespesa: (json['vlrTotalDespesa'] as num).toDouble(),
      dataDespesa: DateTime.parse(json['dataDespesa']),
      competenciaMes: DateTime.parse(json['competenciaMes']),
      compartilhado: json['compartilhado']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'codDespesa': codDespesa,
      'codTipoDespesa': codTipoDespesa,
      'codApto': codApto,
      'vlrTotalDespesa': vlrTotalDespesa,
      'dataDespesa': dataDespesa.toIso8601String(),
      'competenciaMes': competenciaMes.toIso8601String()
    };
  }

  factory Despesa.init(){
    return Despesa(
      codDespesa: 0,
      codTipoDespesa: 0,
      vlrTotalDespesa: 0.0,
      dataDespesa: DateTime.now(),
      competenciaMes: DateTime.now()
    );
  }

  @override
  List<Object?> get props => [
    codDespesa,
    codTipoDespesa,
    nomeTipoDespesa,
    codApto,
    vlrTotalDespesa,
    dataDespesa,
    competenciaMes,
    compartilhado
  ];
}