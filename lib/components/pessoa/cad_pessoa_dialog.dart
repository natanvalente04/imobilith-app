import 'package:alugueis_app/components/dialog/dialog_dropdown.dart';
import 'package:alugueis_app/components/dialog/dialog_textfield.dart';
import 'package:alugueis_app/components/dialog/dialog_textfield_cpf.dart';
import 'package:alugueis_app/components/dialog/dialog_textfield_numeric.dart';
import 'package:alugueis_app/components/dialog/dialog_title.dart';
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
  final _formKey = GlobalKey<FormState>();
    final codPessoaController = TextEditingController();
    final nomeController = TextEditingController();
    final cpfController = TextEditingController();
    final dataNascimentoController = TextEditingController();
    final enderecoController = TextEditingController();
    final telefoneController = TextEditingController();
    final emailController = TextEditingController();
    final rgController = TextEditingController();

    EstadoCivil? estadoCivilSelecionado;
    int? selecionado;
    bool existe = false;

    @override
    void initState() {
      super.initState();
      codPessoaController.text = widget.pessoa?.codPessoa.toString() ?? '';
      nomeController.text = widget.pessoa?.nomePessoa ?? "";
      cpfController.text = widget.pessoa?.cpf ?? "";
      rgController.text = widget.pessoa?.rg ?? "";
      dataNascimentoController.text = Helper.formatDate(widget.pessoa?.dataNascimento ?? DateTime.now()).toString();
      enderecoController.text = widget.pessoa?.endereco ?? "";
      telefoneController.text = widget.pessoa?.telefone ?? "";
      emailController.text = widget.pessoa?.email ?? "";
      estadoCivilSelecionado = widget.pessoa?.estadoCivil;
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SizedBox(
                        width: 60,
                        child: DialogTextfieldNumeric(controller: codPessoaController, labelText: "Codigo", enabled: false),
                      ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DialogTextfield(controller: nomeController, labelText: "Nome", obrigatorio: true,),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DialogTextfieldCpf(controller: cpfController),
                  ),                
                  const SizedBox(width: 16),
                  Expanded(
                    child: DialogTextfieldNumeric(controller: rgController, labelText: "RG")
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DialogTextfield(controller: enderecoController, labelText: "Ultimo Endereço", obrigatorio: true,),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DialogTextfield(controller: telefoneController, labelText: "Telefone/Celular"),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DialogDropdown(
                      store: ValueNotifier(EstadoCivil.values),
                      value: estadoCivilSelecionado?.index,
                      onChanged: (value){
                        setState(() {
                          estadoCivilSelecionado = Helper.getValueEnum(EstadoCivil.values, value!);
                        });
                      },
                      label: "Estado Civil*",
                      itemsBuilder: (values){
                        return values.map<DropdownMenuItem<int>>((ec) {
                          return DropdownMenuItem(
                            value: ec.index,
                            child: Text(ec.label),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: dataNascimentoController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: "Data Nascimento*",
                      ),
                      onTap: () async {
                        final DateTime? selecionado = await showDatePicker(
                          context: context,
                          firstDate: DateTime(DateTime.now().year - 150),
                          lastDate: DateTime(DateTime.now().year + 1),
                        );
                        if (selecionado != null) {
                          setState(() {
                            dataNascimentoController.text = Helper.formatDate(selecionado);
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DialogTextfield(controller: emailController, labelText: "E-mail", obrigatorio: true,),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
            return;
          }
            Pessoa novaPessoa = Pessoa(
              codPessoa: int.tryParse(codPessoaController.text) ?? 0,
              nomePessoa: nomeController.text,
              cpf: cpfController.text,
              rg: rgController.text,
              endereco: enderecoController.text,
              telefone: telefoneController.text,
              email: emailController.text,
              estadoCivil: Helper.getValueEnum(EstadoCivil.values, estadoCivilSelecionado!.index),
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