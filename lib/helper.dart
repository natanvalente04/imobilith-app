import 'package:alugueis_app/components/mensagem_sucesso.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Helper {

  static String formatDouble(double valor, {int casas = 2}) =>
    valor.toStringAsFixed(casas);

  static String formatDate(DateTime data, {String formato = 'dd/MM/yyyy'}) =>
    DateFormat(formato, 'pt_BR').format(data);

  static String formatDateTime(DateTime data, {String formato = 'dd/MM/yyyy HH:mm:ss'}) =>
    DateFormat(formato, 'pt_BR').format(data);
  
  static DateTime parseDateTime(String data, {String formato = 'dd/MM/yyyy'}) =>
    DateFormat(formato, 'pt_BR').parse(data);

  static T getValueEnum<T>(List<T> values, int numero) =>
    values[numero];

  static bool validaDataBR(String data, {String formato = 'dd/MM/yyyy'}) {
    try {
      DateFormat(formato, 'pt_BR').parseStrict(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool validaDataNascimento(String data){
    final dataNascimento = DateFormat("dd/MM/yyyy", 'pt_BR').parseStrict(data);
    if (dataNascimento.isAfter(DateTime.now())){
      return false;
    }
    return true;
  }

  static int calcularIdade(DateTime nascimento) {
    final hoje = DateTime.now();

    int idade = hoje.year - nascimento.year;

    if (hoje.month < nascimento.month ||
        (hoje.month == nascimento.month && hoje.day < nascimento.day)) {
      idade--;
    }

    return idade;
  }

  static MaskTextInputFormatter cpfMask = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: { "#": RegExp(r'[0-9]') },
  );

  static MaskTextInputFormatter phoneMask = MaskTextInputFormatter(
    mask: '(##) # ####-####',
    filter: { "#": RegExp(r'[0-9]') },
  );
  static MaskTextInputFormatter dateMask = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: { "#": RegExp(r'[0-9]') },
  );

    static MaskTextInputFormatter dateMesAnoMask = MaskTextInputFormatter(
    mask: '##/####',
    filter: { "#": RegExp(r'[0-9]') },
  );

  static void showSuccessToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: 20,
        right: 20,
        child: MensagemSucesso(message: message),
      ),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(seconds: 3), () {
      entry.remove();
    });
  }
}