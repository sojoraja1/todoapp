import 'dart:async';
import 'dart:io';
import 'package:todoapp/models/todoitem.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper{

final String tableUser = "todoTable";
final String columnId = "id";
final String columnUsername = "itemName";
final String columnPassword= "dateCreated";
static final DatabaseHelper _instance = DatabaseHelper.internal();
DatabaseHelper.internal();

factory DatabaseHelper()=>_instance;


static Database _db;

Future<Database> get db async{
if (_db!=null) { 

  return _db;

  
}

_db = await initDb();
return _db;

}

  initDb() async {

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentDirectory.path,'todo.db');
    var ourDb = await openDatabase(path,version: 1,onCreate: _onCreate);
    return ourDb;
    
    
      }
      
    
    
    
      void _onCreate(Database db, int version) async {

        return await db.execute(
        "CREATE TABLE $tableUser($columnId INTEGER PRIMARY KEY, $columnUsername TEXT, $columnPassword TEXT)",
      );
  }
  Future<int> saveUser(NoDoItem item) async{

    var dbClient = await db; 

    int res = await dbClient.insert("$tableUser", item.toMap());

    return res;




  }

  Future<List> getAllUsers()async{

    var dbClient = await db;

    var items = await dbClient.rawQuery("SELECT *from $tableUser");


return items.toList();

  }

  Future<int> getAllCount()async{

      var dbClient = await db;

      return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) from $tableUser")
      );

    
  }

  Future<NoDoItem> getUser(int id)async{
    var dbClient = await db;

    var result =await dbClient.rawQuery("SELECT *from $tableUser WHERE $columnId=$id");

    if (result.length==0) return null;

    return NoDoItem.fromMap(result.first);


  }
  Future<int> deleteUser(int id)async{


    var dbClient = await db;

  return await dbClient.delete(tableUser,where:"$columnId=?",whereArgs: [id]);


  }


  Future<int> updateUser(NoDoItem item) async{


    var dbClient = await db;

    return await dbClient.update(tableUser,item.toMap(),where: "$columnId=?",whereArgs: [item.id]);



  }

  Future close()async{
    var dbClient = await db;
    return dbClient.close();

  }

}