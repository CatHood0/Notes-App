import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:notes_project/view/HomePage.dart';
import 'package:notes_project/view/NotesPage.dart';
import 'package:notes_project/view/Settings.dart';

class pages extends StatefulWidget {
  pages({super.key});

  @override
  State<pages> createState() => _pagesState();
}

class _pagesState extends State<pages> {
  int indexPage = 1;

  List<Widget> listPages = [
      homePage(),
      notesPage(null),
      settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: listPages[indexPage],
        bottomNavigationBar: Container(
          color: Color.fromARGB(255, 51, 51, 51),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: GNav(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                backgroundColor: Color.fromARGB(255, 51, 51, 51),
                selectedIndex: indexPage,
                gap: 8,
                rippleColor: Color.fromARGB(255, 181, 124, 255),
                color: Colors.white,
                tabActiveBorder: Border.all(),
                padding: EdgeInsets.all(15),
                tabBackgroundColor: Color.fromARGB(255, 168, 92, 212),
                onTabChange: (value) => {
                   indexPage = value,
                    setState(() => {}),
                },
                tabs: const [
                   GButton(
                    icon: Icons.home,
                    text: "Home",
                   ),
                   GButton(
                    icon: Icons.notes,
                    text: "Notes",
                   ),
                   GButton(
                    icon: Icons.settings,
                    text: "Settings",
                   ),
                ],
            ),
          ),
        ),
    );
  }
}