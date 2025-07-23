import 'package:flutter/material.dart';
import 'package:simple_todo/todo.dart';
import 'package:simple_todo/detailscreen.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key, required this.todos});

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos'),),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, Index) {
          return ListTile(
            title: Text(todos[Index].title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailScreen(),
                  settings: RouteSettings(arguments: todos[Index]),
                ),
              );
             },  
            );
           },
          ),
        );
       }
      }