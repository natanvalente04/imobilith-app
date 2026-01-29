import 'package:alugueis_app/repositories/helper/json_serializable.dart';
import 'package:equatable/equatable.dart';

enum Role {
  admin,
  locatario,
}

extension RoleExt on Role {
  String get label {
    switch (this) {
      case Role.admin:
        return 'Admin';
      case Role.locatario:
        return 'Locatario';
      default:
        return '';
    }
  }
}


class Usuario extends Equatable implements JsonSerializable {
  final int codUsuario;
  final int codPessoa;
  final Role role;
  final String senha;
  final bool ativo;

  Usuario({
    required this.codUsuario,
    required this.codPessoa,
    required this.role,
    required this.senha,
    required this.ativo,
  });

  factory Usuario.init(){
    return Usuario(
      codUsuario: 0,
      codPessoa: 0,
      role: Role.admin,
      senha: "",
      ativo: true,
    );
  }

  @override
  List<Object?> get props => [
    codUsuario,
    codPessoa,
    role,
    senha,
    ativo
  ];

  Map<String, dynamic> toJson() {
    return {
      'codUsuario': codUsuario,
      'codPessoa': codPessoa,
      'role': role.index,
      'senha': senha,
      'ativo': ativo,
    };
  }
  
  factory Usuario.fromJson(Map<String, dynamic> json){
    return Usuario(
      codUsuario: json['codUsuario'],
      codPessoa: json['codPessoa'], 
      role: json['role'], 
      senha: json['senha'], 
      ativo: json['ativo']
    );
  }
}