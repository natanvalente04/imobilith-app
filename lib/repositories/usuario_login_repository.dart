import 'dart:convert';

import 'package:alugueis_app/models/authentication.dart';
import 'package:alugueis_app/models/usuario_login.dart';
import 'package:alugueis_app/repositories/helper/repository_helper.dart';
import 'package:http/http.dart';

class UsuarioLoginRepository {
  final repositoryHelper = RepositoryHelper();
  final client = Client();
  final uriUsuarioLogin = 'https://localhost:7052/api/auth/';

  Future<Authentication> Login(UsuarioLogin login) async {
    final json = repositoryHelper.parseToJson(login);
    final response = await client.post(
      Uri.parse(uriUsuarioLogin),
      headers: {'Content-Type': 'application/json'},
      body: json
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseT<Authentication>(jsonRaw, Authentication.fromJson);
  }
}