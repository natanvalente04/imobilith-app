import 'package:alugueis_app/models/pessoa.dart';
import 'package:alugueis_app/repositories/helper/repository_helper.dart';
import 'package:alugueis_app/repositories/helper/token_storage.dart';
import 'package:http/http.dart';

class PessoaRepository {
  final repositoryHelper = RepositoryHelper();
  final client = Client();
  final uriPessoa = 'https://localhost:7052/api/Pessoa/';

  Future<List<Pessoa>> getPessoas() async {
    final token = await TokenStorage.getToken();
    final response = await client.get(Uri.parse(uriPessoa),
      headers: {
            'Authorization': 'Bearer $token'
      },
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseListT<Pessoa>(jsonRaw, Pessoa.fromJson);
  }

  Future<Pessoa> getPessoaById(int codPessoa) async {
    final token = await TokenStorage.getToken();
    final response = await client.get(Uri.parse(uriPessoa + codPessoa.toString()),
      headers: {
            'Authorization': 'Bearer $token'
      },
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseT<Pessoa>(jsonRaw, Pessoa.fromJson);
  }

  Future addPessoa(Pessoa pessoa) async {
    String json = repositoryHelper.parseToJson(pessoa);
    final token = await TokenStorage.getToken();
    final response = await client.post(
      Uri.parse(uriPessoa),
      headers:{
        "Content-Type": "application/json; charset=UTF-8",
        'Authorization': 'Bearer $token'
      },
      body: json
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseT<Pessoa>(jsonRaw, Pessoa.fromJson);
  }

  Future updatePessoa(Pessoa pessoaAtualizada) async {
    String json = repositoryHelper.parseToJson(pessoaAtualizada);
    final token = await TokenStorage.getToken();
    final response = await client.put(
      Uri.parse(uriPessoa),
      headers:{
        "Content-Type": "application/json; charset=UTF-8",
        'Authorization': 'Bearer $token'
      },
      body: json
    );
  }

  Future deletePessoa(int codPessoa) async {
    final token = await TokenStorage.getToken();
    await client.delete(
      Uri.parse(uriPessoa + codPessoa.toString()),
      headers:{
        'Authorization': 'Bearer $token'
      },
    );

  }
}