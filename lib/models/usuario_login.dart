import 'package:alugueis_app/repositories/helper/json_serializable.dart';

class UsuarioLogin implements JsonSerializable{
  final String login;
  final String senha;

  UsuarioLogin({
    required this.login,
    required this.senha,
  });

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'senha': senha
    };
  }

  factory UsuarioLogin.init(){
    return UsuarioLogin(
      login: "",
      senha: "",
    );
  }
}