import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:translation_data/database/database_service.dart';
import 'package:translation_data/model/translation_model.dart';
import 'package:translation_data/post.dart';
import 'package:translation_data/database/resource_translation_db.dart';
import 'package:translation_data/database/database_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


 
class _HomePageState extends State<HomePage> {
  late Future<List<ResourceModel>> futureResource;


  @override
    void initState() {
    super.initState();
    // Initialize futureResource to null initially
    futureResource = retrieveData(); // Call the function to fetch data
    }
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            
            await fetchAndStore();
            
          } catch (e) {
            
          }
        },
        child: Icon(
          Icons.refresh, 
          color: Colors.green),
      ),
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
            margin: EdgeInsets.only(top: 10, left: 20, right: 20),
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
          Container(
            margin: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: null,
                  child: Text('Language ID')
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: null,
                  child: Text('Module ID')
                ),
                SizedBox(width: 10,),

                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  
                  onPressed:() {
                    final translationDB = translation_data_DB();
                    translationDB.clearTable();
                  },
                  child: Text('Search')
                ),
              ],
            ),
          ),


          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20,left: 15,right: 15),
              child:FutureBuilder<List<ResourceModel>>(
                future: futureResource,
                builder: (context, AsyncSnapshot<List<ResourceModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    // Access the Resource object from snapshot.data
                    List<ResourceModel> resources = snapshot.data!;
                    
                    // Assuming you want to display a ListView of a list of Resources,
                    // you can access the specific fields of the Resource object like this:
                    return ListView.builder(
                      itemCount: resources.length, // Assuming you're displaying a single resource
                      itemBuilder: (context, index) {
                        ResourceModel resource = resources[index];
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
    throw Exception('Failed to load Resources');
  }

}
Future<List<ResourceModel>> fetchAndStore() async {
  try {
    final translationDB = translation_data_DB();

    // Fetch resources from the API
    List<Resource> resources = await fetchResource();

    // Convert fetched resources to ResourceModel objects
    List<ResourceModel> resourceModels = resources.map((resource) {
      return ResourceModel(
        createdAt: resource.createdAt,
        updatedAt: resource.updatedAt,
        resourceId: resource.resourceId,
        moduleId: resource.moduleId,
        value: resource.value,
        languageId: resource.languageId,
      );
    }).toList();
    await translationDB.clearTable();
    // Store the ResourceModel objects in the database

    for (ResourceModel resourceModel in resourceModels) {
      await translationDB.createResource(resourceModel);
    }

    return resourceModels;
  } catch (e) {
    // Handle any errors that occur during the fetch and store process
    print('Error fetching and storing resources: $e');
    rethrow; // Optionally rethrow the error to handle it elsewhere
  }
}

Future<List<ResourceModel>> retrieveData() async {
  // Create an instance of your database service
  final translationDB = translation_data_DB();

  // Call the function to read all columns from the database
  List<Map<String, dynamic>> queryResponse = await translationDB.readAll();

  // Convert the database results into a list of ResourceModel objects
  List<ResourceModel> resources = queryResponse.map((result) {
    // Extract fields from the database result
    return ResourceModel(
      createdAt: result['createdAt'],
      updatedAt: result['updatedAt'],
      resourceId: result['resourceId'],
      moduleId: result['moduleId'],
      value: result['value'],
      languageId: result['languageId'],
    );
  }).toList();

  return resources; // Return the list of ResourceModel objects
}