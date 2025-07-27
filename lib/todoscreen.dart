import 'package:flutter/material.dart';
import 'package:simple_todo/todo.dart';
import 'package:simple_todo/detailscreen.dart';
import 'package:simple_todo/addtodo.dart'; 

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Todo> todos = [];

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
