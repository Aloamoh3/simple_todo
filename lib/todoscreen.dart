import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:simple_todo/helper.dart';
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
  List<Todo> todos = [];
  
  List<String> savedTodo = <String>[];

  @override
  void initState() {
     _getTodos();
    super.initState();
  }
Future<void> _getTodos() async {
  var todo = await deserializeTodo(savedTodo, todos);
    setState(() {
      todos = todo;
    });
}

// Future<void> serializeTODO() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   savedTodo.clear();
//   for (int i = 0; i < todos.length; i++) {
//     String todo = json.encode(todos[i]);
//     print(todo);
//     savedTodo.add(todo);
//   }
//     await prefs.setStringList("todo", savedTodo);
//   }


// Future<void> deserializeTodo() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var fromMem = prefs.getStringList("todo");
//  if (fromMem != null) {
//   print(fromMem.length);
//   todos.clear();
//   savedTodo = fromMem;
//   for (int i = 0; i < savedTodo.length; i++) {
//     print(savedTodo[i]);
//     Todo todo = Todo.fromJson(json.decode(savedTodo[i]));
//     setState(() {
//       todos.add(todo);
      
//     });
//   }
//  }
// }

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
                    _navigateToDetails( context, todos[index]);
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

  Future<void> _navigateToDetails(BuildContext context, Todo todoDetail) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => const DetailScreen(),
      settings: RouteSettings(arguments: todoDetail),
     ),
    );
       if (result != null && result is Todo) {
        await _getTodos();
      setState(() {
      });
     }
    }

  Future<void> _navigateAndDisplayAddTodo(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTodo()),
    );

    if (!context.mounted) return;

    if (result != null && result is Todo) {
      setState(() {
        todos.add(result);
        serializeTODO(savedTodo, todos);
      });
    }
  }
}
