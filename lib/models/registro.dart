import 'package:alugueis_app/models/pessoa.dart';
import 'package:alugueis_app/models/usuario.dart';
import 'package:alugueis_app/repositories/helper/json_serializable.dart';

class Registro extends JsonSerializable{
  final Usuario usuario;
  final Pessoa pessoa;

  Registro({
    required this.usuario,
    required this.pessoa
  });
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'usuario': usuario.toJson(),
      'pessoa': pessoa.toJson()
    };
  }
}