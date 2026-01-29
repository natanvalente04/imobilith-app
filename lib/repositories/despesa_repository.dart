import 'package:alugueis_app/models/despesa.dart';
import 'package:alugueis_app/repositories/helper/repository_helper.dart';
import 'package:alugueis_app/repositories/helper/token_storage.dart';
import 'package:http/http.dart';

class DespesaRepository {
  final repositoryHelper = RepositoryHelper();
  final client = Client();
  final uriDespesa = 'https://localhost:7052/api/DespesaApto/';
  final token = TokenStorage.getToken();

  Future<List<Despesa>> getDespesas() async {
    final response = await client.get(Uri.parse(uriDespesa));
    final jsonRaw = response.body;
    return repositoryHelper.parseListT<Despesa>(jsonRaw, Despesa.fromJson);
  }

  Future<Despesa> addDespesa(Despesa despesa) async {
    final json = repositoryHelper.parseToJson(despesa);
    final token = await TokenStorage.getToken();
    final response = await client.post(
      Uri.parse(uriDespesa),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseT<Despesa>(jsonRaw, Despesa.fromJson);
  }

  Future<void> deleteDespesa(int codDespesa) async {
    final token = await TokenStorage.getToken();
    await client.delete(Uri.parse(uriDespesa + codDespesa.toString()),
      headers: {
          'Authorization': 'Bearer $token'
        },
    );
  }

  Future<Despesa> updateDespesa(Despesa despesaAtualizado) async {
    final json = repositoryHelper.parseToJson(despesaAtualizado);
    final response = await client.put(
      Uri.parse(uriDespesa),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: json
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseT<Despesa>(jsonRaw, Despesa.fromJson);
  }
}