import 'package:alugueis_app/components/dialog/dialog_dropdown.dart';
import 'package:alugueis_app/components/dialog/dialog_textfield.dart';
import 'package:alugueis_app/components/dialog/dialog_textfield_numeric.dart';
import 'package:alugueis_app/components/dialog/dialog_textfield_senha.dart';
import 'package:alugueis_app/components/dialog/dialog_title.dart';
import 'package:alugueis_app/helper.dart';
import 'package:alugueis_app/models/usuario.dart';
import 'package:alugueis_app/store/locatario_store.dart';
import 'package:alugueis_app/store/pessoa_store.dart';
import 'package:alugueis_app/store/usuario_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CadUsuarioDialog extends StatefulWidget {
  final UsuarioStore store;
  final PessoaStore pessoaStore;
  final LocatarioStore? locatarioStore;
  final Usuario? usuario;
  const CadUsuarioDialog({super.key, required this.store, required this.pessoaStore, this.usuario, this.locatarioStore});

  @override
  State<CadUsuarioDialog> createState() => _CadUsuarioDialogState();
}

class _CadUsuarioDialogState extends State<CadUsuarioDialog> {
  final codUsuarioController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmaSenhaController = TextEditingController();
  final codLocatarioController = TextEditingController();
  final dependentesController = TextEditingController();
  int? temPet;
  int? pessoaSelecionada;
  Role? roleSelecionada;
  bool existe = false;
  bool ativo = true;


  @override
  void initState(){
    super.initState();
    codUsuarioController.text = widget.usuario?.codUsuario.toString() ?? "";
    pessoaSelecionada = widget.usuario?.codPessoa ?? 0;
    senhaController.text = widget.usuario?.senha ?? "";

    if(widget.usuario != null){
      existe = true;
    }

    widget.pessoaStore.getPessoas();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: DialogTitle(title: "Cadastrar usuario"),
      content: SizedBox(
        width: 500,
        height: roleSelecionada == Role.locatario ? 250 : 190,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: DialogTextfield(controller: codUsuarioController, labelText: "Código", enabled: false,),
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                    child: DialogDropdown(
                      store: widget.pessoaStore, 
                      itemsBuilder: (State){
                        return State.pessoas.map((pessoa) {
                          return DropdownMenuItem(
                            value: pessoa.codPessoa,
                            child: Text(pessoa.cpf.toString() + " - " + pessoa.nomePessoa),
                          );
                        }).toList();
                      }, 
                      value: pessoaSelecionada, 
                      onChanged: (value){
                        setState(() {
                          pessoaSelecionada = value;
                        });
                      }, 
                      label: "Pessoa*"
                    )
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 140,
                    child: SwitchListTile(
                      contentPadding: EdgeInsets.only(right: 20),
                      title: Text("Ativo"),
                      value: ativo,
                      onChanged: (value) {
                        setState(() => ativo = value);
                      },
                    ),
                  ),
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
              if (roleSelecionada == Role.locatario) Row(
                  children: [
                    Expanded(
                      child: DialogTextfieldNumeric(
                        controller: dependentesController,
                        labelText: "Quantidade de dependentes*",
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: temPet,
                        decoration: const InputDecoration(
                          labelText: "Possui pet?*",
                        ),
                        items: const [
                          DropdownMenuItem(value: 1, child: Text("Sim")),
                          DropdownMenuItem(value: 0, child: Text("Não"))
                        ],
                        onChanged: (value){
                          setState((){
                            temPet = value;
                          });
                        }
                      ),
                    )
                  ],
                ),
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
        actions: [
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text("cancelar")
        ),
        ElevatedButton(
          onPressed: () {
            Usuario novoUsuario = Usuario(
              codUsuario: int.tryParse(codUsuarioController.text) ?? 0,
              codPessoa: pessoaSelecionada ?? 0,
              ativo: ativo,
              role: Helper.getValueEnum(Role.values, roleSelecionada!.index),
              senha: senhaController.text,
            );
            existe ?
            widget.store.updateUsuario(novoUsuario)
            : widget.store.addUsuario(novoUsuario);
            Navigator.pop(context);
          },
          child: const Text("Salvar")
        )
      ],
    );
  }
}