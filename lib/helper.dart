import 'package:intl/intl.dart';

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
}