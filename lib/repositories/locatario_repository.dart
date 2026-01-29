// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:alugueis_app/models/locatario.dart';
import 'package:alugueis_app/repositories/helper/repository_helper.dart';
import 'package:alugueis_app/repositories/helper/token_storage.dart';
import 'package:http/http.dart';

class LocatarioRepository {
  final repositoryHelper = RepositoryHelper();
  final client = Client();
  final uriLocatario = 'https://localhost:7052/api/Locatario/';


  Future<List<Locatario>> getLocatarios() async {
    final token = await TokenStorage.getToken();
    final response = await client.get(Uri.parse(uriLocatario),
      headers: {
          'Authorization': 'Bearer $token'
      },
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseListT<Locatario>(jsonRaw, Locatario.fromJson);
  }

  Future addLocatario(Locatario locatario) async {
    String json = repositoryHelper.parseToJson(locatario);
    final token = await TokenStorage.getToken();
    final response = await client.post(
      Uri.parse(uriLocatario), 
      headers: {
      "Content-Type": "application/json; charset=UTF-8",
      'Authorization': 'Bearer $token'
      },
      body: json
      );
      final jsonRaw = response.body;
      return repositoryHelper.parseT<Locatario>(jsonRaw, Locatario.fromJson);
  }

  Future deleteLocatario(int codLocatario) async{
    final token = await TokenStorage.getToken();
    await client.delete(Uri.parse(uriLocatario + codLocatario.toString()),
      headers: {
          'Authorization': 'Bearer $token'
      },
    );
  }

  Future updateLocatario(Locatario locatarioAtualizado) async {
    String json = repositoryHelper.parseToJson(locatarioAtualizado);
    final token = await TokenStorage.getToken();
    final response = await client.put(
      Uri.parse(uriLocatario),
      headers: {
      "Content-Type": "application/json; charset=UTF-8",
      'Authorization': 'Bearer $token'
      },
      body: json 
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseT<Locatario>(jsonRaw, Locatario.fromJson);
  }
}