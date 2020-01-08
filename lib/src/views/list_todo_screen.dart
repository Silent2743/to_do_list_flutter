

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:todo_app/src/database/todo_db_helper.dart';
import 'package:todo_app/src/models/todo.dart';
import 'package:todo_app/src/views/create_todo_screen.dart';

class ListTodoScreen extends StatefulWidget {
  @override
  _ListTodoScreenState createState() => _ListTodoScreenState();
}

class _ListTodoScreenState extends State<ListTodoScreen> {
  final TodoDBHelper _todoDBHelper = TodoDBHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Todo App'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: _todoDBHelper.getAllTodo(),
          builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
            if (snapshot.data.length != 0) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateTodoScreen(todo: snapshot.data[index],)));
                      },
                      child: Card(
                        child: ListTile(
                          leading: Icon(MdiIcons.nintendoSwitch),
                          title: Text(snapshot.data[index].task),
                          trailing: Icon(MdiIcons.ninja),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Padding(
                padding: const EdgeInsets.fromLTRB(45, 35, 10, 10),
                child: Column(
                  children: <Widget>[
                    Image.asset("assets/images/clx.png"),
                    Text("Ayo isi task anda"),
                  ],
                ),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateTodoScreen()));
        },
        child: Icon(MdiIcons.xbox),
      ),
    );
  }
}
