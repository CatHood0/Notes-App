import 'package:flutter/material.dart';

class dialogSearch extends StatefulWidget {
  dialogSearch({super.key});

  @override
  State<dialogSearch> createState() => _dialogSearchState();
}

class _dialogSearchState extends State<dialogSearch> {

  late TextEditingController textSearchController = TextEditingController();
  late String search;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color.fromARGB(255, 58, 58, 58),
        elevation: 10,    
          child: Container(
            height: 200,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container( 
                  margin: EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  child: Text("Search your note", style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
               
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    autocorrect: true,
                    controller: textSearchController,
                    decoration: InputDecoration(
                        helperText: "Example: Cookies",
                        helperStyle: TextStyle(color: Color.fromARGB(255, 155, 155, 155), fontSize: 15),
                    ),
                    onSaved: (newValue) => search = newValue!,
                    onChanged: (value) => search = value,
                  ),
                ),
                MaterialButton(
                  child: Icon(Icons.search, color: Colors.white,),
                  onPressed: () {
                  },
                ),
              ]
            ), 
          ),     
      );
  }
}