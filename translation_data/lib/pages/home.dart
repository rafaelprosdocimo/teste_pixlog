import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

const data = [
  {'resource_id': '11', 'updated_at' : '12', 'value': 'wrada'},
  {'resource_id': '113', 'updated_at' : '123', 'value': 'wradawrada'},

  ];
  
 
class _HomePageState extends State<HomePage> {
  
  
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recursos de tradução',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40, left: 20, right: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black38.withOpacity(0.11),
                  blurRadius: 40,
                  spreadRadius: 0.0
                  )
              ]
            ),
            child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(15),
              hintText: 'filtragem',
              hintStyle: TextStyle(
                color: Color(0xffDDDADA),
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none
              )
            ),
          ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20,left: 15,right: 15),
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(top: 20,left: 15,right: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: ListTile(
                    isThreeLine: true,
                    title: Text(data[index]['value']!),
                    subtitle: Text("Resource Id:" + data[index]['resource_id']! + "\n"+ "Updated at:" + data[index]['updated_at']!),
                    
                  ),
                )
                
              ),
            ),
          ),
        ],
        ),
    );
  }
}