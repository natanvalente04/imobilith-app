import 'dart:convert';

import 'package:alugueis_app/models/authentication.dart';
import 'package:alugueis_app/models/registro.dart';
import 'package:alugueis_app/models/usuario.dart';
import 'package:alugueis_app/models/usuario_login.dart';
import 'package:alugueis_app/repositories/helper/repository_helper.dart';
import 'package:http/http.dart';

class RegistroRepository {
  final repositoryHelper = RepositoryHelper();
  final client = Client();
  final uriRegistro = 'https://localhost:7052/api/auth/registrar';

  Future<void> Register(Registro registro) async {
    final json = repositoryHelper.parseToJson(registro);
    final response = await client.post(
      Uri.parse(uriRegistro),
      headers: {'Content-Type': 'application/json'},
      body: json
    );
    final jsonRaw = response.body;
  }
}