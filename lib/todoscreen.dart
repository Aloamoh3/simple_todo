import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:simple_todo/todo.dart';
import 'package:simple_todo/detailscreen.dart';
import 'package:simple_todo/addtodo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Todo> todos = [];
  
  List<String> savedTodo = List.empty();

  @override
  void initState() {
    deserializeTodo();
    super.initState();
  }

Future<void> serializeTODO() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  savedTodo.clear();
  for (int i = 0; i < todos.length; i++) {
    String todo = json.encode(todos[i]);
    savedTodo.add(todo);
  }
    await prefs.setStringList("todo", savedTodo);
  }


Future<void> deserializeTodo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var fromMem = prefs.getStringList("todo");
 if (fromMem != null) {
  todos.clear();
  savedTodo = fromMem;
  for (int i = 0; i < savedTodo.length; i++) {
    todos.add(Todo.fromJson(json.decode(savedTodo[i])));
  }
 }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: todos.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 90),
                  const Icon(
                    Icons.space_bar_rounded,
                    size: 150,
                    color: Colors.deepPurpleAccent,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "There are no 100s.",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index].title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailScreen(),
                        settings: RouteSettings(arguments: todos[index]),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateAndDisplayAddTodo(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _navigateAndDisplayAddTodo(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTodo()),
    );

    if (result != null && result is Todo) {
      setState(() {
        todos.add(result);
      });
    }
  }
}
