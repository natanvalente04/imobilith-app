import 'package:alugueis_app/models/tipo_despesa.dart';
import 'package:alugueis_app/repositories/tipo_despesa_repository.dart';
import 'package:alugueis_app/states/tipo_despesa_state.dart';
import 'package:flutter/cupertino.dart';

class TipoDespesaStore  extends ValueNotifier<TipoDespesaState>{
  final repository = TipoDespesaRepository();
  TipoDespesaStore() : super(TipoDespesaState.init());

  Future<void> getTiposDespesa()async{
    final tiposDespesa = await repository.getTiposDespesa();
    value = value.copyWith(tiposDespesa: tiposDespesa);
  }

  Future<TipoDespesa?> getTipoDespesaById(int codTipoDespesa)async{
    final TipoDespesa? tipoDespesa = await repository.getTipoDespesaById(codTipoDespesa);
    return tipoDespesa;
  }

  Future<void> addTipoDespesa(TipoDespesa tipoDespesa) async {
    TipoDespesa tipoDespesaNovo = await repository.addTipoDespesa(tipoDespesa);
    value = value.copyWith(
      tiposDespesa: [...value.tiposDespesa, tipoDespesaNovo]
    );
  }

  Future<void> deleteTipoDespesa(int codTipoDespesa) async {
    await repository.deleteTipoDespesa(codTipoDespesa);
    getTiposDespesa();
  }

  Future<void> updateTipoDespesa(TipoDespesa tipoDespesaAtualizado) async {
    await repository.updateTipoDespesa(tipoDespesaAtualizado);
    getTiposDespesa();
  }
}