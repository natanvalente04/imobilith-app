import 'package:alugueis_app/helper.dart';
import 'package:alugueis_app/repositories/helper/json_serializable.dart';
import 'package:equatable/equatable.dart';

enum EstadoCivil{
  solteiro,
  casado,
  divorciado,
  viuvo,
}

extension EstadoCivilExt on EstadoCivil {
  String get label {
    switch (this) {
      case EstadoCivil.solteiro:
        return 'Solteiro';
      case EstadoCivil.casado:
        return 'Casado';
      case EstadoCivil.divorciado:
        return 'Divorciado';
      case EstadoCivil.viuvo:
        return 'Viuvo';
      default:
        return '';
    }
  }
}

class Pessoa extends Equatable implements JsonSerializable {
  final int codPessoa;
  final int? codLocatario;
  final String nomePessoa;
  final String cpf;
  final String rg;
  final String endereco;
  final String telefone;
  final String email;
  final EstadoCivil estadoCivil;
  final DateTime dataNascimento;

  Pessoa({
    required this.codPessoa,
    this.codLocatario,
    required this.nomePessoa,
    required this.cpf,
    required this.rg,
    required this.endereco,
    required this.telefone,
    required this.email,
    required this.estadoCivil,
    required this.dataNascimento
  });

  factory Pessoa.init(){
    return Pessoa(
      codPessoa: 0,
      codLocatario: null,
      nomePessoa: "",
      cpf: "",
      rg: "",
      endereco: "",
      telefone: "",
      email: "",
      estadoCivil: EstadoCivil.solteiro,
      dataNascimento: DateTime.now()
    );
  }

  @override
  List<Object?> get props => [
    codPessoa,
    codLocatario,
    nomePessoa,
    cpf,
    rg,
    endereco,
    telefone,
    email,
    estadoCivil,
    dataNascimento
  ];

  Map<String, dynamic> toJson() {
    return {
      'codPessoa': codPessoa,
      'codLocataraio': codLocatario,
      'nomePessoa': nomePessoa,
      'cpf': cpf,
      'rg': rg,
      'endereco': endereco,
      'telefone': telefone,
      'email': email,
      'estadoCivil': estadoCivil.index,
      'dataNascimento': dataNascimento.toIso8601String(),
    };
  }
  
  factory Pessoa.fromJson(Map<String, dynamic> json){
    return Pessoa(
    codPessoa: json['codPessoa'],
    codLocatario: json['codLocatario'],
    nomePessoa: json['nomePessoa'],
    cpf: json['cpf'],
    rg: json['rg'],
    endereco: json['endereco'],
    telefone: json['telefone'],
    email: json['email'],
    estadoCivil: Helper.getValueEnum(EstadoCivil.values, json['estadoCivil']),
    dataNascimento: DateTime.parse(json['dataNascimento'])
    );
  }
}