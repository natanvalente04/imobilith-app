
import 'package:alugueis_app/models/predio.dart';
import 'package:alugueis_app/repositories/helper/repository_helper.dart';
import 'package:alugueis_app/repositories/helper/token_storage.dart';
import 'package:http/http.dart';

class PredioRepository {
  final repositoryHelper = RepositoryHelper();
  final client = Client();
  final uriPredio = 'https://localhost:7052/api/Predio/';

  Future<List<Predio>> getPredios() async {
    final token = await TokenStorage.getToken();
    final response = await client.get(Uri.parse(uriPredio),
    headers: {
          'Authorization': 'Bearer $token'
        },
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseListT<Predio>(jsonRaw, Predio.fromJson);
  }

  Future<Predio> addPredio(Predio predio) async {
    final json = repositoryHelper.parseToJson(predio);
    final token = await TokenStorage.getToken();
    final response = await client.post(
      Uri.parse(uriPredio),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'Authorization': 'Bearer $token'
      },
      body: json
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseT<Predio>(jsonRaw, Predio.fromJson);
  }

  Future<void> deletePredio(int codPredio) async {
    final token = await TokenStorage.getToken();
    await client.delete(
      Uri.parse(uriPredio+codPredio.toString()),
      headers: {
        'Authorization': 'Bearer $token'
      },
      );
  }

  Future<Predio> updatePredio(Predio predioAtualizado) async {
    final json = repositoryHelper.parseToJson(predioAtualizado);
    final token = await TokenStorage.getToken();
    final response = await client.put(
      Uri.parse(uriPredio),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'Authorization': 'Bearer $token'
      },
      body: json
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseT<Predio>(jsonRaw, Predio.fromJson);
  }

  Future<Predio> getPredioById(int? codPredio) async {
    final token = await TokenStorage.getToken();
    final response = await client.get(
      Uri.parse(uriPredio + codPredio.toString()),
      headers: {
        'Authorization': 'Bearer $token'
      },
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseT(jsonRaw, Predio.fromJson);
  }
}