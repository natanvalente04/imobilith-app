import 'package:alugueis_app/components/dialog/dialog_dropdown.dart';
import 'package:alugueis_app/components/dialog/dialog_dropdown_listenable.dart';
import 'package:alugueis_app/components/dialog/dialog_textfield.dart';
import 'package:alugueis_app/components/dialog/dialog_textfield_numeric.dart';
import 'package:alugueis_app/components/dialog/dialog_textfield_senha.dart';
import 'package:alugueis_app/components/dialog/dialog_title.dart';
import 'package:alugueis_app/helper.dart';
import 'package:alugueis_app/models/locatario.dart';
import 'package:alugueis_app/models/pessoa.dart';
import 'package:alugueis_app/models/usuario.dart';
import 'package:alugueis_app/store/locatario_store.dart';
import 'package:alugueis_app/store/pessoa_store.dart';
import 'package:alugueis_app/store/usuario_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CadUsuarioDialog extends StatefulWidget  {
  final UsuarioStore store;
  final PessoaStore pessoaStore;
  final LocatarioStore locatarioStore;
  final Usuario? usuario;
  const CadUsuarioDialog({super.key, required this.store, required this.pessoaStore, this.usuario, required this.locatarioStore});

  @override
  State<CadUsuarioDialog> createState() => _CadUsuarioDialogState();
}

class _CadUsuarioDialogState extends State<CadUsuarioDialog>  with TickerProviderStateMixin{
  final _formKey = GlobalKey<FormState>();
  final codUsuarioController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmaSenhaController = TextEditingController();
  final codLocatarioController = TextEditingController();
  final dependentesController = TextEditingController();
  Locatario? locatarioAtual;
  int? temPet;
  int? pessoaSelecionada;
  Role? roleSelecionada;
  bool mostrarCamposLocatario = false;
  bool existe = false;
  bool existeLocatario = false;
  bool ativo = true;


  @override
  void initState() {
    super.initState();
    codUsuarioController.text = widget.usuario?.codUsuario.toString() ?? "";
    pessoaSelecionada = widget.usuario?.codPessoa ?? null;
    codLocatarioController.text = locatarioAtual?.codLocatario.toString() ?? "";
    temPet = locatarioAtual?.temPet ?? null;
    dependentesController.text = locatarioAtual?.qtdDependentes.toString() ?? "";
    roleSelecionada = widget.usuario?.role;
    if(pessoaSelecionada != null){
      _GetLocatarioByPessoaId(pessoaSelecionada!);
    }
    if(widget.usuario != null){
      existe = true;
    }

    widget.pessoaStore.getPessoas();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: DialogTitle(title: "Cadastrar usuario"),
      content: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 230,
            maxHeight: roleSelecionada == Role.locatario ? 450 : 280,
            minWidth: 550
          ),
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: DialogTextfield(controller: codUsuarioController, labelText: "Código", enabled: false,),
                        ),
                        const SizedBox(width: 16,),
                        Expanded(
                          child: DialogDropdownListenable(
                            store: widget.pessoaStore, 
                            obrigatorio: true,
                            itemsBuilder: (State){
                              return State.pessoas.map((pessoa) {
                                return DropdownMenuItem(
                                  value: pessoa.codPessoa,
                                  child: Text(pessoa.nomePessoa +' (' + pessoa.cpf + ')'),
                                );
                              }).toList();
                            }, 
                            value: pessoaSelecionada, 
                            onChanged: (value) async {
                              if(value != null){
                                Locatario? locatario = await GetLocatarioByPessoaIdAsync(value!);
                                if(locatario != null){
                                  setState(() {
                                    pessoaSelecionada = value;
                                    roleSelecionada = Role.locatario;
                                    locatarioAtual = locatario;
                                    mostrarCamposLocatario = true;
                                    existeLocatario = mostrarCamposLocatario; 
                                    codLocatarioController.text = locatarioAtual?.codLocatario.toString() ?? "";
                                    temPet = locatarioAtual?.temPet ?? null;
                                    dependentesController.text = locatarioAtual?.qtdDependentes.toString() ?? "";
                                  });
                                  return;
                                }
                              }
                              setState(() {
                                    locatarioAtual = null;
                                    pessoaSelecionada = value;
                                    mostrarCamposLocatario = false;
                                    existeLocatario = mostrarCamposLocatario; 
                                    codLocatarioController.text = locatarioAtual?.codLocatario.toString() ?? "";
                                    temPet = locatarioAtual?.temPet ?? null;
                                    dependentesController.text = locatarioAtual?.qtdDependentes.toString() ?? "";
                              });
                              await Future.delayed(const Duration(milliseconds: 200));
                              setState(() {
                                roleSelecionada = null;
                              });
                            }, 
                            label: "Pessoa"
                          )
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
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
                          child: DialogDropdownListenable(
                            store: ValueNotifier(Role.values),
                            value: roleSelecionada?.index,
                            obrigatorio: true,
                            onChanged: (value) async {
                              Role novaRole = Helper.getValueEnum(Role.values, value!);
                              if (roleSelecionada == Role.locatario &&
                                  novaRole != Role.locatario) {
                                setState(() {
                                  mostrarCamposLocatario = false;
                                });
                                await Future.delayed(const Duration(milliseconds: 200));
                                setState(() {
                                  roleSelecionada = novaRole;
                                });

                                return;
                              }

                              if (novaRole == Role.locatario) {
                                setState(() {
                                  roleSelecionada = novaRole;
                                  mostrarCamposLocatario = true;
                                });
                                return;
                              }
                            },
                            label: "Tipo Usuario",
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
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: mostrarCamposLocatario
                      ? Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Row(
                        children: [
                          Expanded(
                            child: DialogTextfieldNumeric(
                              controller: dependentesController,
                              labelText: "Quantidade de dependentes",
                              obrigatorio: true,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DialogDropdown(
                              value: temPet,
                              label: "Possui pet?",
                              obrigatorio: true,
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
                      )
                    : const SizedBox.shrink(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: DialogTextfieldSenha(controller: senhaController, labelText: "Senha",),
                        ),
                        const SizedBox(width: 16,),
                        Expanded(
                          child: DialogTextfieldSenha(controller: confirmaSenhaController, labelText: "Confirma senha"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
          ),
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
            if (!_formKey.currentState!.validate()) {
            return;
          }
            Usuario novoUsuario = Usuario(
              codUsuario: int.tryParse(codUsuarioController.text) ?? 0,
              codPessoa: pessoaSelecionada ?? 0,
              ativo: ativo,
              role: Helper.getValueEnum(Role.values, roleSelecionada!.index),
              senha: senhaController.text,
            );
            if(roleSelecionada == Role.locatario){
              Locatario novoLocatario = Locatario(
                codLocatario: int.tryParse(codLocatarioController.text) ?? 0, 
                codPessoa: pessoaSelecionada ?? 0, 
                temPet: temPet ?? 0, 
                qtdDependentes: int.tryParse(dependentesController.text) ?? 0,
              );
              existeLocatario ?
              widget.locatarioStore.updateLocatario(novoLocatario)
              : widget.locatarioStore.addLocatario(novoLocatario);
            }
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

  Future<void> _GetLocatarioByPessoaId(int codPessoa) async {
    Pessoa? pessoa = await widget.pessoaStore.getPessoaById(codPessoa);
    if(pessoa!.codLocatario == null) {
      return;
    }
    Locatario? locatario = await widget.locatarioStore.GetLocatarioById(pessoa.codLocatario!);

    if(!mounted) return;

    if(locatario != null){
      setState(() {
        roleSelecionada = Role.locatario;
        locatarioAtual = locatario;
        mostrarCamposLocatario = true;
        existeLocatario = mostrarCamposLocatario; 
        codLocatarioController.text = locatarioAtual?.codLocatario.toString() ?? "";
        temPet = locatarioAtual?.temPet ?? null;
        dependentesController.text = locatarioAtual?.qtdDependentes.toString() ?? "";
      });
    }
  }

  Future<Locatario?> GetLocatarioByPessoaIdAsync(int codPessoa) async {
    Pessoa? pessoa = await widget.pessoaStore.getPessoaById(codPessoa);

    if(pessoa!.codLocatario == null) return null;
    if( pessoa.codLocatario! <= 0) return null;

    Locatario? locatario = await widget.locatarioStore.GetLocatarioById(pessoa.codLocatario!);

    return locatario;
  }
}