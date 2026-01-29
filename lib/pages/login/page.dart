// ignore_for_file: avoid_unnecessary_containers

import 'package:alugueis_app/components/login/login_header.dart';
import 'package:alugueis_app/components/login/login_menu.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children:[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[ 
                  LoginHeader(),
                  const SizedBox(height: 50),
                  LoginMenu()
                ]
              )
            )
          ] 
        )
      ),
    );
  }
}