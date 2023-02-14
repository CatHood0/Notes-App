import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class menu extends StatelessWidget {
  const menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Color.fromARGB(255, 70, 70, 70),
        elevation: 0,
        child: ListView(
          children: [
             DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero, 
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 43, 43, 43),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/circle-avatar.png"
                    ),
                  ),
                    accountName: Text("Username"),
                    accountEmail: Text("user@gmail.com"),
                ),
             ),
            ListTile(//esto nos deja crear una lista de objetos usables
                leading: Icon(//leading es casi que pegado a la izquierda
                  size: 20,
                  CupertinoIcons.home, color: Colors.white,
                ),
                shape: StadiumBorder(),
                title: Text("Home", style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold)),
                onTap: () => {
                    print("Hola"),
                },
            ),
             ListTile(//esto nos deja crear una lista de objetos usables
                leading: Icon(//leading es casi que pegado a la izquierda
                size: 20,
                  CupertinoIcons.book, color: Colors.white,
                ),
                shape: StadiumBorder(),
                title: Text("Notes", style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold)),
                onTap: () => {
                    print("Hola"),
                },
            ),
             ListTile(//esto nos deja crear una lista de objetos usables
                leading: Icon(//leading es casi que pegado a la izquierda
                size: 20,
                  CupertinoIcons.settings_solid, color: Colors.white,
                ),
                shape: StadiumBorder(),
                title: Text("Settings", style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold)),
                onTap: () => {
                    print("Hola"),
                },
            ),
            
          ],
        ),
    );
  }
}