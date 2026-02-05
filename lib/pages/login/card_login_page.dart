import 'package:alugueis_app/components/dialog/dialog_textfield.dart';
import 'package:alugueis_app/components/dialog/dialog_textfield_senha.dart';
import 'package:alugueis_app/components/login/login_button.dart';
import 'package:alugueis_app/components/menu/menu.dart';
import 'package:alugueis_app/models/authentication.dart';
import 'package:alugueis_app/models/usuario_login.dart';
import 'package:alugueis_app/pages/login/page.dart';
import 'package:alugueis_app/repositories/helper/token_storage.dart';
import 'package:alugueis_app/store/tipo_despesa_store.dart';
import 'package:alugueis_app/store/usuario_store.dart';
import 'package:flutter/material.dart';

class CardLoginPage extends StatefulWidget {
  final UsuarioStore store = UsuarioStore();
  CardLoginPage({super.key});

  @override
  State<CardLoginPage> createState() => _CardLoginPageState();
}

class _CardLoginPageState extends State<CardLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: 320,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                          ),
                          Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                  
                      DialogTextfield(
                        controller: emailController,
                        labelText: 'E-mail',
                        obrigatorio: true,
                      ),
                  
                      const SizedBox(height: 16),
                  
                      DialogTextfieldSenha(
                        controller: senhaController,
                        labelText: 'Senha',
                      ),
                  
                      const SizedBox(height: 24),
                  
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: LoginButton(
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            UsuarioLogin usuarioLogin = UsuarioLogin(
                              login: emailController.text,
                              senha: senhaController.text,
                            );
                            await widget.store.Login(usuarioLogin);
                            if (await TokenStorage.isLoggedIn()){
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Menu()),
                              );
                            }
                          },
                          text:'Entrar',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}