// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

List<Todo> todoFromJson(String str) => List<Todo>.from(json.decode(str).map((x) => Todo.fromMap(x)));

String todoToJson(List<Todo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Todo {
    int id;
    String task;
    String description;

    Todo({
        this.id,
        this.task,
        this.description,
    });

    factory Todo.fromMap(Map<String, dynamic> json) => Todo(
        id: json["id"],
        task: json["task"],
        description: json["description"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "task": task,
        "description": description,
    };
}
