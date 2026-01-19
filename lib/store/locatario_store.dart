import 'package:alugueis_app/models/locatario.dart';
import 'package:alugueis_app/repositories/locatario_repository.dart';
import 'package:alugueis_app/states/locatario_state.dart';
import 'package:flutter/cupertino.dart';

class LocatarioStore extends ValueNotifier<LocatarioState> {
  final repository = LocatarioRepository();
  LocatarioStore() : super(LocatarioState.init());

  Future<void> getLocatarios() async {
    final locatarios = await repository.getLocatarios();

    value = value.copyWith(locatarios: locatarios);
  }

  Future<void> addLocatario(Locatario locatario) async {
    Locatario locatarionovo = await repository.addLocatario(locatario);
    value = value.copyWith(
      locatarios: [...value.locatarios, locatarionovo],
    );
  }

  Future<void> deleteLocatario(int codLocatario) async {
    await repository.deleteLocatario(codLocatario);
    getLocatarios();
  }

  Future<void> updateLocatario(Locatario locatarioAtualizado) async {
    await repository.updateLocatario( locatarioAtualizado);
    getLocatarios();
  }
}