// ignore_for_file: deprecated_member_use

import 'package:alugueis_app/pages/login/page.dart';
import 'package:alugueis_app/components/menu/menu_items.dart';
import 'package:alugueis_app/repositories/helper/token_storage.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
    final controller = MenuItems();
    int currentIdenx = 0;
    bool selectedItem = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          background(
            Column(
              children: [
                Expanded(
                  flex: 3,
                  child: ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (context,index){
                    selectedItem = currentIdenx == index;
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: selectedItem ? Colors.deepPurple.withOpacity(.2) : Colors.transparent
                      ),
                      child: ListTile(
                        title: Text(controller.items[index].title, style: TextStyle(color: Colors.deepPurple),),
                        leading: Icon(controller.items[index].icon, color: Colors.deepPurple,),
                        onTap: (){
                          setState(() {
                            currentIdenx = index;
                          });
                        },
                      ),
                    );
                  }
                ),
                ),
                Expanded(
                  child: 
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [ListTile(
                        title: Text('Logout', style: TextStyle(color: Colors.deepPurple),),
                        leading: Icon(Icons.logout, color: Colors.deepPurple),
                        onTap: () async {
                          await TokenStorage.clear();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage())
                          );
                        },
                      )
                    ]
                  ),
                )
              ],
            )
          ),
          Expanded(
            child: PageView.builder(
              itemCount: controller.items.length,
              itemBuilder: (context, index){
                return controller.items[currentIdenx].page;
            })
          )
        ],
      ),
    );
  }
}

Widget background(Widget child){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    width: 200,
    height: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(.8),
          blurRadius: 1,
          spreadRadius: 0
        )
      ],
      color: Colors.white),
    child: child,
  );
}