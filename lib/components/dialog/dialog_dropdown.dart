import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DialogDropdown extends StatelessWidget {
  final List<DropdownMenuItem<int>> items;
  final int? value;
  final void Function(int?)? onChanged;
  final String label;
  final bool enabled;
  final bool obrigatorio;
  final String? Function(int?)? validator;

  const DialogDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.label,
    this.obrigatorio = false,
    this.enabled=true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: value,
      items: items,
      onChanged: enabled ? onChanged : null,
      decoration: InputDecoration(
        labelText: obrigatorio ? label + "*" : label,
        enabled: enabled),
      validator: validator ?? (value) {
        if (obrigatorio && (value == null)) {
          return 'Campo Obrigatório!';
        }
        return null;
      },
    );
  }
}
