import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DialogDropdown<T> extends StatelessWidget {
  final ValueListenable<T> store;
  final List<DropdownMenuItem<int>> Function(T state) itemsBuilder;
  final int? value;
  final void Function(int?) onChanged;
  final String label;
  final bool enabled;

  const DialogDropdown({
    super.key,
    required this.store,
    required this.itemsBuilder,
    required this.value,
    required this.onChanged,
    required this.label,
    this.enabled=true,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: store,
      builder: (context, state, _) {
        return DropdownButtonFormField<int>(
          value: value,
          items: itemsBuilder(state),
          onChanged: enabled ? onChanged : null,
          decoration: InputDecoration(labelText: label, enabled: enabled),
        );
      },
    );
  }
}
