import 'package:alugueis_app/models/apto.dart';
import 'package:alugueis_app/repositories/helper/repository_helper.dart';
import 'package:alugueis_app/repositories/helper/token_storage.dart';
import 'package:http/http.dart';

class AptoRepository {
  final repositoryHelper = RepositoryHelper();
  final client = Client(); 
  final uriApto = 'https://localhost:7052/api/Apto/';

  Future<List<Apto>> getAptos() async {
    final token = await TokenStorage.getToken();
    final response = await client.get(Uri.parse(uriApto),
      headers: {
          'Authorization': 'Bearer $token'
        },
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseListT<Apto>(jsonRaw, Apto.fromJson);
  }

  Future<Apto> addApto(Apto apto) async {
    final json = repositoryHelper.parseToJson(apto);
    final token = await TokenStorage.getToken();
    final response = await client.post(
      Uri.parse(uriApto),
      headers: {'Content-Type': 'application/json','Authorization': 'Bearer $token'},
      body: json  
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseT<Apto>(jsonRaw, Apto.fromJson);
  }

  Future<void> deleteApto(int codApto) async {
    await client.delete(Uri.parse(uriApto + codApto.toString()));
  }

  Future<Apto> updateApto(Apto aptoAtualizado) async{
    final json = repositoryHelper.parseToJson(aptoAtualizado);
    final token = await TokenStorage.getToken();
    final response = await client.put(
      Uri.parse(uriApto),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json
    );
    final jsonRaw = response.body;
    return repositoryHelper.parseT<Apto>(jsonRaw, Apto.fromJson);
  }
}