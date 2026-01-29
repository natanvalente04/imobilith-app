import 'dart:convert';

import 'package:alugueis_app/models/usuario.dart';
import 'package:alugueis_app/repositories/helper/repository_helper.dart';
import 'package:alugueis_app/repositories/helper/token_storage.dart';
import 'package:http/http.dart';

class UsuarioRepository {
  final repositoryHelper = RepositoryHelper();
  final client = Client();
  final uriUsuario = 'https://localhost:7052/api/Usuario/';

  Future<bool> existeUsuario() async {
    final response = await client.get(Uri.parse(uriUsuario + 'existe'));
    if (response.statusCode == 200) {
      return response.body.toLowerCase() == 'true';
    }
    return true;
  }

  Future<Usuario> addUsuario(Usuario usuario) async {
    final json = repositoryHelper.parseToJson(usuario);
    final token = await TokenStorage.getToken();
    final response = await client.post(
      Uri.parse(uriUsuario),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: json
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseT<Usuario>(jsonRaw, Usuario.fromJson);
  }

  Future<void> deleteUsuario(int codUsuario) async {
    final token = await TokenStorage.getToken();
    await client.delete(
      Uri.parse(uriUsuario + codUsuario.toString()),
      headers: {
        'Authorization': 'Bearer $token'
      },
    );
  }

  Future<Usuario> updateUsuario(Usuario usuarioAtualizado) async {
    final json = repositoryHelper.parseToJson(usuarioAtualizado);
    final token = await TokenStorage.getToken();
    final response = await client.put(
      Uri.parse(uriUsuario),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: json
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseT<Usuario>(jsonRaw, Usuario.fromJson);
  }

  Future<List<Usuario>> getUsuarios() async {
    final token = await TokenStorage.getToken();
    final response = await client.get(
      Uri.parse(uriUsuario),
      headers: {
        'Authorization': 'Bearer $token'
      },
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseListT(jsonRaw, Usuario.fromJson);
  }
}