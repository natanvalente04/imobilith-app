import 'package:alugueis_app/components/login/login_button.dart';
import 'package:alugueis_app/components/login/login_registro_dialog.dart';
import 'package:alugueis_app/components/menu/menu.dart';
import 'package:alugueis_app/helper.dart';
import 'package:alugueis_app/pages/login/card_login_page.dart';
import 'package:alugueis_app/store/usuario_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginMenu extends StatefulWidget {
  const LoginMenu({super.key});

  @override
  State<LoginMenu> createState() => _LoginMenuState();
}

class _LoginMenuState extends State<LoginMenu> {
  bool showRegister = false;

    void initState() {
    super.initState();
    _checkFirstAccess();
  }

  void _checkFirstAccess() async {
    final usuarioStore = UsuarioStore();
    bool exists = await usuarioStore.existeUsuario();
    setState(() {
      showRegister = !exists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showRegister) LoginButton(
            text: 'Cadastrar',
            onPressed: () {
              showDialog(context: context, builder: (_) => LoginRegistroDialog(), barrierColor: const Color.fromARGB(0,0,0,0));
            },
            outlined: true,
           ),
          if (showRegister) SizedBox(width: 20),
          LoginButton(
            text: 'Entrar',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CardLoginPage()),
              );
            }, 
            outlined: false
          )
        ],
      )
    );
  }
}