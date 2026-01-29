import 'package:alugueis_app/components/menu/menu_details.dart';
import 'package:alugueis_app/pages/aptos/page.dart';
import 'package:alugueis_app/pages/despesas/page.dart';
import 'package:alugueis_app/pages/home/page.dart';
import 'package:alugueis_app/pages/locatarios/page.dart';
import 'package:alugueis_app/pages/pessoas/page.dart';
import 'package:alugueis_app/pages/predios/page.dart';
import 'package:alugueis_app/pages/tipos_despesa/page.dart';
import 'package:alugueis_app/pages/usuarios/page.dart';
import 'package:flutter/material.dart';

class MenuItems {
  List<MenuDetails> items = [
    MenuDetails(title: "Home", icon: Icons.home, page: HomePage()),
    MenuDetails(title: "Aptos", icon: Icons.apartment, page: AptoPage()),
    MenuDetails(title: "Despesas", icon: Icons.money_off, page: DespesaPage()),
    // MenuDetails(title: "Locatarios", icon: Icons.people, page: LocatarioPage()),
    MenuDetails(title: "Pessoas", icon: Icons.people, page: PessoaPage()),
    MenuDetails(title: "Usuarios", icon: Icons.people, page: UsuarioPage()),
    MenuDetails(title: "Tipos Despesa", icon: Icons.monetization_on, page: TiposDespesaPage()),
    MenuDetails(title: "Predios", icon: Icons.location_city, page: PredioPage()),
  ];
}