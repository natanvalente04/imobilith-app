// ignore_for_file: unnecessary_this

import 'package:alugueis_app/repositories/helper/json_serializable.dart';
import 'package:equatable/equatable.dart';

class Locatario extends Equatable implements JsonSerializable{
  final int codLocatario;
  final int codPessoa;
  final int temPet;
  final int qtdDependentes;
  const Locatario({
    required this.codLocatario,
    required this.codPessoa,
    required this.temPet,
    required this.qtdDependentes,
  });

  factory Locatario.fromJson(Map<String, dynamic> json){
    return Locatario(
      codLocatario: json['codLocatario'],
        codPessoa: json['codPessoa'], 
        temPet: json['temPet'], 
        qtdDependentes: json['qtdDependentes'], 
      );
  }

  Map<String, dynamic> toJson(){
    return {
      'codLocatario': this.codLocatario,
      'codPessoa': this.codPessoa,
      'temPet': this.temPet,
      'qtdDependentes': this.qtdDependentes,
    };
  }

  factory Locatario.init(){
    return Locatario(
      codLocatario: 0,
      codPessoa: 0,
      temPet: 0,
      qtdDependentes: 0,
    );
  }

  @override
  List<Object?> get props => [
    codLocatario,
    codPessoa, 
    temPet, 
    qtdDependentes,
    ];
}