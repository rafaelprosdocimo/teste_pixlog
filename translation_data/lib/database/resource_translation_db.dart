import 'package:sqflite/sqflite.dart';

import 'package:translation_data/database/database_service.dart';
import 'package:translation_data/model/translation_model.dart';
class translation_data_DB {

  final tableName = 'resource_data_table';


  Future<void> createTable(Database database) async {
    await database.execute("""
      CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT,
      "createdAt" TEXT NOT NULL,
      "updatedAt" TEXT NOT NULL,
      "resourceId" TEXT NOT NULL,
      "moduleId" TEXT NOT NULL,
      "value" TEXT NOT NULL,
      "languageId" TEXT NOT NULL
      );
    """
    );
  }
    Future<void> clearTable() async {
    final database = await DatabaseService().database;
    await database.delete(tableName); 
  }

  Future<int> createResource(ResourceModel resource) async {
    final database = await DatabaseService().database;
    return await database.insert(tableName, resource.toMap());
  }

  Future<List<Map<String, dynamic>>> readAll() async {
    final database = await DatabaseService().database;

    final List<Map<String, dynamic>> results = await database.query(tableName);

    return results;
  }
}