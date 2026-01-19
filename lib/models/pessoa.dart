import 'package:alugueis_app/repositories/helper/json_serializable.dart';
import 'package:equatable/equatable.dart';

enum EstadoCivil{
  solteiro,
  casado,
  divorciado,
  viuvo,
}

class Pessoa extends Equatable implements JsonSerializable {
  final int codPessoa;
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
      'nomePessoa': nomePessoa,
      'cpf': cpf,
      'rg': rg,
      'endereco': endereco,
      'telefone': telefone,
      'email': email,
      'estadoCivil': estadoCivil,
      'dataNascimento': dataNascimento,
    };
  }
  
  factory Pessoa.fromJson(Map<String, dynamic> json){
    return Pessoa(
    codPessoa: json['codPessoa'],
    nomePessoa: json['nomePessoa'],
    cpf: json['cpf'],
    rg: json['rg'],
    endereco: json['endereco'],
    telefone: json['telefone'],
    email: json['email'],
    estadoCivil: json['estadoCivil'],
    dataNascimento: json['dataNascimento']
    );
  }
}