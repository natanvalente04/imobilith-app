import 'package:alugueis_app/models/registro.dart';
import 'package:alugueis_app/repositories/registro_repository.dart';

class RegistroStore {
  final repository = RegistroRepository();

  Future<void> Register(Registro registro) async {
    await repository.Register(registro);
  }
}