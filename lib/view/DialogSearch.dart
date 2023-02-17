import 'package:flutter/material.dart';

class dialogSearch extends StatefulWidget {
  dialogSearch({super.key});

  @override
  State<dialogSearch> createState() => _dialogSearchState();
}

class _dialogSearchState extends State<dialogSearch> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 10,    
          child: Container(
            child: Column(
              children: [
                Text("Search your note"),
                TextFormField(
                  autocorrect: true,
                  autofocus: true,
                  
                  decoration: InputDecoration(

                  ),

                ),
                MaterialButton(
                  onPressed: () {

                  },
                ),
              ]
            ), 
          ),     
      );
  }
}