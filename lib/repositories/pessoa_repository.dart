import 'package:alugueis_app/models/pessoa.dart';
import 'package:alugueis_app/repositories/helper/repository_helper.dart';
import 'package:http/http.dart';

class PessoaRepository {
  final repositoryHelper = RepositoryHelper();
  final client = Client();
  final uriPessoa = 'https://localhost:7052/api/Pessoa/';

  Future<List<Pessoa>> getPessoas() async {
    final response = await client.get(Uri.parse(uriPessoa));
    final jsonRaw = response.body;
    return repositoryHelper.parseListT<Pessoa>(jsonRaw, Pessoa.fromJson);
  }

  Future addPessoa(Pessoa pessoa) async {
    String json = repositoryHelper.parseToJson(pessoa);
    final response = await client.post(
      Uri.parse(uriPessoa),
      headers:{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: json
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseT<Pessoa>(jsonRaw, Pessoa.fromJson);
  }

    Future updatePessoa(Pessoa pessoaAtualizada) async {
    String json = repositoryHelper.parseToJson(pessoaAtualizada);
    final response = await client.put(
      Uri.parse(uriPessoa),
      headers:{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: json
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseT<Pessoa>(jsonRaw, Pessoa.fromJson);
  }
}