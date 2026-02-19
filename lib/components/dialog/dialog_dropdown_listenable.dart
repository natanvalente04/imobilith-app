import 'package:alugueis_app/components/dialog/dialog_dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DialogDropdownListenable<T> extends StatelessWidget {
  final ValueListenable<T> store;
  final List<DropdownMenuItem<int>> Function(T state) itemsBuilder;
  final int? value;
  final void Function(int?)? onChanged;
  final String label;
  final bool enabled;
  final bool obrigatorio;
  final String? Function(int?)? validator;

  const DialogDropdownListenable({
    super.key,
    required this.store,
    required this.itemsBuilder,
    required this.value,
    required this.onChanged,
    required this.label,
    this.obrigatorio = false,
    this.enabled=true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: store,
      builder: (context, state, _) {
        return DialogDropdown(
          value: value,
          items: itemsBuilder(state),
          onChanged: onChanged,
          obrigatorio: obrigatorio,
          label: label,
          enabled: enabled,
          validator: validator,
        );
      },
    );
  }
}
