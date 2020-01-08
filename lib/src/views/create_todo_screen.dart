import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:todo_app/src/database/todo_db_helper.dart';
import 'package:todo_app/src/models/todo.dart';

class CreateTodoScreen extends StatefulWidget {
  final Todo todo;
  CreateTodoScreen({Key key, this.todo}) : super(key: key);
  @override
  _CreateTodoScreenState createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    if (widget.todo != null) {
      taskController.text = widget.todo.task;
      descriptionController.text = widget.todo.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('todo'),
        iconTheme: IconThemeData(color: Colors.redAccent),
        actions: <Widget>[
          InkWell(
            onTap: (){
              deleteTodo();

            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(MdiIcons.check),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: taskController,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              maxLines: 3,
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
          )
        ],
      ),
      floatingActionButton: Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: RaisedButton(
              color: Colors.grey,
              onPressed: () {
                saveTodo();
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.black,
                ),
              ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future saveTodo() async {
    var db = TodoDBHelper();
    var todo = Todo(
      task: taskController.text,
      description: descriptionController.text,
    );
    var result;
    if (widget.todo != null) {
      todo.id = widget.todo.id;
      result = await db.updateTodo(todo, widget.todo.id);
      Navigator.pop(context);
    } else {
      result = await db.addTodo(todo);
    }

    if (result == 0) {
      Navigator.pop(context);
    }
  }

  Future deleteTodo()async{
    var db = TodoDBHelper();
    var result = await db.deleteTodo(widget.todo.id);

    if(result != 0){
      Navigator.pop(context);
    }
  }
}
