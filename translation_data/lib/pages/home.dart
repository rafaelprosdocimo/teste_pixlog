import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:translation_data/post.dart';



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
  late Future<List<Resource>> futureResource;


  @override
    void initState() {
    super.initState();
    futureResource = fetchResource();
  }
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
              child:FutureBuilder<List<Resource>>(
                future: futureResource,
                builder: (context, AsyncSnapshot<List<Resource>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    // Access the Resource object from snapshot.data
                    List<Resource> resources = snapshot.data!;
                    
                    // Assuming you want to display a ListView of a list of Resources,
                    // you can access the specific fields of the Resource object like this:
                    return ListView.builder(
                      itemCount: resources.length, // Assuming you're displaying a single resource
                      itemBuilder: (context, index) {
                        Resource resource = resources[index];
                        return Container(
                        
                        margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          isThreeLine: true,
                          title: Text(resource.value),
                          subtitle: Text(
                            "Resource Id: ${resource.resourceId}\nUpdated at: ${resource.updatedAt}",
                          ),
                        ),
                      );},
                    );
                  } else {
                    return Center(child: Text('No data available'));
                  }
                }
                
              ),
            ),
          ),
        ],
        ),
    );
  }
}


Future<List<Resource>> fetchResource() async {
  final response = await http
      .get(Uri.parse('http://portal.greenmilesoftware.com/get_resources_since'));

  if (response.statusCode == 200) {
    List<dynamic> jsonData = jsonDecode(response.body);
    List<Resource> resources = jsonData.map((json) => Resource.fromJson(json)).toList();
    return resources;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}