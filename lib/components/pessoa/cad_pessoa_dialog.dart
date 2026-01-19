import 'package:alugueis_app/components/dialog_title.dart';
import 'package:alugueis_app/helper.dart';
import 'package:alugueis_app/models/pessoa.dart';
import 'package:alugueis_app/store/locatario_store.dart';
import 'package:alugueis_app/store/pessoa_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadPessoaDialog extends StatefulWidget {
  final PessoaStore store;
  final Pessoa? pessoa;
  const CadPessoaDialog({super.key, required this.store, this.pessoa});

  @override
  State<CadPessoaDialog> createState() => _CadPessoaDialogState();

}

class _CadPessoaDialogState extends State<CadPessoaDialog> {
    final codPessoaController = TextEditingController();
    final nomeController = TextEditingController();
    final cpfController = TextEditingController();
    final dataNascimentoController = TextEditingController();
    final enderecoController = TextEditingController();
    final telefoneController = TextEditingController();
    final emailController = TextEditingController();
    final estadoCivilController = TextEditingController();
    final rgController = TextEditingController();

    int? selecionado;
    bool existe = false;
    final cpfMask = MaskTextInputFormatter(
        mask: '###.###.###-##',
        filter: { "#": RegExp(r'[0-9]') },
      );
    @override
    void initState() {
      super.initState();
      nomeController.text = widget.pessoa?.nomePessoa ?? "";
      cpfController.text = widget.pessoa?.cpf ?? "";
      dataNascimentoController.text = widget.pessoa?.dataNascimento.toString() ?? "";
      enderecoController.text = widget.pessoa?.endereco ?? "";
      if(widget.pessoa != null){
        existe = true;
      }
    }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: DialogTitle(title: "Cadastrar Pessoa"),
      content: SizedBox(
        width: 750,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: "Nome*"),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: cpfController,
                    decoration: InputDecoration(labelText: "CPF*"),
                    enabled: !existe,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      cpfMask
                    ],                  
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: dataNascimentoController,
                    decoration: InputDecoration(labelText: "Data Nascimento*"),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  )
                )
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: enderecoController,
              decoration: InputDecoration(labelText: "Ultimo Endereço*"),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: rgController,
                    decoration: InputDecoration(labelText: "RG*"),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: selecionado,
                    decoration: const InputDecoration(
                      labelText: "Possui pet?",
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 1, child: Text("Sim")),
                      DropdownMenuItem(value: 0, child: Text("Não"))
                    ],
                    onChanged: (value){
                      setState((){
                        selecionado = value;
                      });
                    }
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
            Pessoa novaPessoa = Pessoa(
              codPessoa: int.tryParse(codPessoaController.text) ?? 0,
              nomePessoa: nomeController.text,
              cpf: cpfController.text,
              rg: rgController.text,
              endereco: enderecoController.text,
              telefone: telefoneController.text,
              email: emailController.text,
              estadoCivil: Helper.getValueEnum(EstadoCivil.values, int.tryParse(estadoCivilController.text) ?? 0),
              dataNascimento: Helper.parseDateTime(dataNascimentoController.text),

            );
            existe ? 
            widget.store.updatePessoa(novaPessoa)
            : widget.store.addPessoa(novaPessoa);
            Navigator.pop(context);
          },
          child: const Text("Salvar"),
        ),
      ],
    );
  }
}