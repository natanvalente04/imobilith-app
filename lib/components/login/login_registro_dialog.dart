import 'package:alugueis_app/components/dialog/dialog_dropdown.dart';
import 'package:alugueis_app/components/dialog/dialog_textfield.dart';
import 'package:alugueis_app/components/dialog/dialog_textfield_cpf.dart';
import 'package:alugueis_app/components/dialog/dialog_textfield_numeric.dart';
import 'package:alugueis_app/components/dialog/dialog_textfield_phone.dart';
import 'package:alugueis_app/components/dialog/dialog_textfield_senha.dart';
import 'package:alugueis_app/components/dialog/dialog_title.dart';
import 'package:alugueis_app/components/login/login_button.dart';
import 'package:alugueis_app/helper.dart';
import 'package:alugueis_app/models/pessoa.dart';
import 'package:alugueis_app/models/registro.dart';
import 'package:alugueis_app/models/usuario.dart';
import 'package:alugueis_app/store/registro_store.dart';
import 'package:flutter/material.dart';

class LoginRegistroDialog extends StatefulWidget {
  final RegistroStore store = RegistroStore();
  LoginRegistroDialog({super.key});

  @override
  State<LoginRegistroDialog> createState() => _LoginRegistroDialogState();
}

class _LoginRegistroDialogState extends State<LoginRegistroDialog> {
  final codPessoaController = TextEditingController();
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final dataNascimentoController = TextEditingController();
  final enderecoController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();
  final rgController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmaSenhaController = TextEditingController();
  Role? roleSelecionada = Role.admin;
  int? dataNascimentoSelecionada;

  EstadoCivil? estadoCivilSelecionado;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      child: SizedBox(
        width: 490,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DialogTitle(title: "Registrar-se", fontSize: 24,),
                  Container(
                    height: 420,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: DialogTextfield(controller: nomeController, labelText: "Nome*"),
                            ),
                          ],
                        ),
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
                        DialogTextfield(controller: enderecoController, labelText: "Ultimo Endereço*"),
                        Row(
                          children: [
                            Expanded(
                              child: DialogTextfieldPhone(controller: telefoneController, labelText: "Telefone/Celular"),
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
                              child: DialogDropdown(
                                store: ValueNotifier(Role.values),
                                value: roleSelecionada?.index,
                                onChanged: (value){
                                  setState(() {
                                    roleSelecionada = Helper.getValueEnum(Role.values, value!);
                                  });
                                },
                                label: "Tipo Usuario*",
                                enabled: false,
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
                        DialogTextfield(controller: emailController, labelText: "E-mail*"),
                        Row(
                          children: [
                            Expanded(
                              child: DialogTextfieldSenha(controller: senhaController, labelText: "Senha*"),
                            ),
                            const SizedBox(width: 16,),
                            Expanded(
                              child: DialogTextfieldSenha(controller: confirmaSenhaController, labelText: "Confirma senha*"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancelar"),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color>(Colors.white)),
                        onPressed: () async {
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
                          Usuario novoUsuario = Usuario(
                            codUsuario: int.tryParse(codPessoaController.text) ?? 0,
                            codPessoa: int.tryParse(codPessoaController.text) ?? 0,
                            ativo: true,
                            role: Helper.getValueEnum(Role.values, roleSelecionada!.index),
                            senha: senhaController.text,
                          );
                          Registro novoRegistro = Registro(
                            usuario: novoUsuario,
                            pessoa: novaPessoa
                          );
                          await widget.store.Register(novoRegistro);
                          Helper.showSuccessToast(context, "Cadastrado com sucesso!");
                          Navigator.pop(context);
                        },
                        child: const Text("Salvar"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}