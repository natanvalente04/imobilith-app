import 'package:alugueis_app/models/locacao.dart';
import 'package:alugueis_app/repositories/helper/repository_helper.dart';
import 'package:alugueis_app/repositories/helper/token_storage.dart';
import 'package:http/http.dart';

class LocacaoRepository {
  final repositoryHelper = RepositoryHelper();
  final client = Client();
  final uriLocacao = 'https://localhost:7052/api/Locacao/';

  Future<List<Locacao>> getLocacoesAtivas() async {
    final token = await TokenStorage.getToken();
    final response = await client.get(
      Uri.parse(uriLocacao + 'ativas'),
      headers: {'Authorization': 'Bearer $token'},      
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseListT<Locacao>(jsonRaw, Locacao.fromJson);
  }

    Future<List<Locacao>> getLocacoes() async {
    final token = await TokenStorage.getToken();
    final response = await client.get(
      Uri.parse(uriLocacao),
      headers: {'Authorization': 'Bearer $token'},      
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseListT<Locacao>(jsonRaw, Locacao.fromJson);
  }

    Future<Locacao> addLocacao(Locacao locacao) async {
    final json = repositoryHelper.parseToJson(locacao);
    final token = await TokenStorage.getToken();
    final response = await client.post(
      Uri.parse(uriLocacao),
      headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token'},
      body: json  
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseT<Locacao>(jsonRaw, Locacao.fromJson);
  }

  Future<void> deleteLocacao(int codLocacao) async {
    final token = await TokenStorage.getToken();
    await client.delete(
      Uri.parse(uriLocacao + codLocacao.toString()),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<Locacao> updateLocacao(Locacao locacaoAtualizado) async{
    final json = repositoryHelper.parseToJson(locacaoAtualizado);
    final token = await TokenStorage.getToken();
    final response = await client.put(
      Uri.parse(uriLocacao),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseT<Locacao>(jsonRaw, Locacao.fromJson);
  }

}