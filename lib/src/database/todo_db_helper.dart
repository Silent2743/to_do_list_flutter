import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/src/models/todo.dart';

class TodoDBHelper{
  static final TodoDBHelper _instance = new TodoDBHelper.internal();
TodoDBHelper.internal();

factory TodoDBHelper() => _instance;
static Database _db;
Future<Database> get db async{
  if(_db !=null){
    return _db;
  }
  _db = await setDB();
  return _db;
}
Future<Database>setDB() async{
  Directory directory = await getApplicationDocumentsDirectory();
  String path = join(directory.path,"Todo");

  var db = await openDatabase(path, version:1, onCreate: _onCreate);
    return db;
  }
  
  _onCreate(Database db, int version) async{
    await db.execute("CREATE TABLE Todo ("
    "id INTEGER PRIMARY KEY AUTOINCREMENT,"
    "task VARCHAR(191) NOT NULL,"
    "description VARCHAR(191) NOT NULL)");
  }
  Future<List<Todo>> getAllTodo() async{
    var dbClient = await db;

    var list = await dbClient.query('Todo');
    List<Todo> todoList= List<Todo>();

    for(var i =0; i<list.length; i++){
      todoList.add(Todo.fromMap(list[i]));
    }
    return todoList;
  }

  Future<int> addTodo(Todo todo)async{
    var dbClient = await db;

    int response = await dbClient.insert('Todo', todo.toMap());
    return response;
  }
  Future<int> updateTodo(Todo todo, int id)async{
    var dbClient = await db;

    int response = await dbClient.update('Todo', todo.toMap(),where: "id =?", whereArgs: [id]);
    return response;
  }
  Future<int> deleteTodo( int id)async{
    var dbClient = await db;

    int response = await dbClient.delete('Todo',where: "id =?", whereArgs: [id]);
    return response;
  }
}