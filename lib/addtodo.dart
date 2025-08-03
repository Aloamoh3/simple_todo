import 'package:flutter/material.dart';
import 'package:simple_todo/todo.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();



class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Todo")),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add Title",
              ),
              onChanged: (value) {
                setState(() {
                  title = value;
                });
                },
               ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add Description",
              ),
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (title.isEmpty || description.isEmpty) {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Please enter a title and description for your todo.",
                        ),
                      ),
                    );
                } else {
                  Todo todo = createTodo(title, description);
                  Navigator.pop(context, todo);
                }
              },
              child: const Text("Add Todo"),
            ),
          ],
        ),
      ),
    );
  }
}

Todo createTodo(String title, String description) {
  String id = uuid.v1();
  return Todo(
   title: title,
   description: description,
   done: false,
   id: id
 );
}
