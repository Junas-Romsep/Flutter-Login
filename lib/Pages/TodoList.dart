// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List todos = [];
  String input = "";

  createTodos() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyTodos").doc(input);
    Map<String, String> todos = {"todosTitle": input};
    documentReference.set(todos).whenComplete(() {
      // ignore: avoid_print
      print("$input created");
    });
  }

  deleteTodos(item) {
    DocumentReference documentReference =
     FirebaseFirestore.instance.collection("MyTodos").doc(item);
   
    documentReference.delete().whenComplete(() {
      // ignore: avoid_print
      print("Deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Att Göra Lista"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  title: const Text("Att Göra Lista"),
                  content: TextField(
                    onChanged: (String value) {
                      input = value;
                    },
                  ),
                  actions: <Widget>[
                    // ignore: deprecated_member_use
                    FlatButton(
                        onPressed: () {
                          createTodos();
                          setState(() {
                            todos.add(input);
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text("Adda")),
                  ],
                );
              });
        },
        // ignore: prefer_const_constructors
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Mytodos").snapshots(),
          builder: (context, snapshots) {
            return ListView.builder(
              shrinkWrap: true,
                itemCount: todos.length,
                itemBuilder: ( context, index) {
                  return Dismissible(
                      key: Key(index.toString()),
                      child: Card(
                        elevation: 4,
                        margin: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: ListTile(
                          title: Text(todos[index]),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                                             setState(() {
                        todos.removeAt(index);
                      });
                            },
                          ),
                        ),
                      ));
                });
          }),
    );
  }
}
