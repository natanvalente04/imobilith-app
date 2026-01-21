import 'package:flutter/material.dart';

class DatagridDeleteButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const DatagridDeleteButton({super.key, this.onPressed});


  Future<void> _confirmDelete(BuildContext context) async {
    if (onPressed == null) return;

    final bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirmação"),
          content: Text("Tem certeza que deseja excluir?"),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () => Navigator.pop(context, false),
            ),
            ElevatedButton(
              child: Text("Excluir"),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );

    if (confirmar == true) {
      onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _confirmDelete(context),
      hoverColor: Colors.grey[300],
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(4),
          color: Colors.transparent
        ),
        child: Icon(Icons.delete),
      ),
    );
  }
}