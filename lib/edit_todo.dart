import 'package:flutter/material.dart';
import 'package:simple_todo/helper.dart';
import 'package:simple_todo/todo.dart';

class EditTodo extends StatefulWidget {
    const EditTodo({super.key});

    @override
    State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  String title = '';
  String description = '';
  TextEditingController titleEdit = TextEditingController();
  TextEditingController descEdit = TextEditingController();

  late Todo todo;
  
  List<Todo> todos = [];
  
  List<String> savedTodo = <String>[];

  @override
  void initState() {
    _getTodos();
    super.initState();
    todo = ModalRoute.of(context)!.settings.arguments as Todo;
    titleEdit.text = todo.title;
    descEdit.text = todo.description;
  }
Future<void> _getTodos() async {
   todos = await deserializeTodo(savedTodo, todos);
}


    @override
    Widget build(BuildContext context) {
        
        return Scaffold(
         appBar: AppBar(title: const Text("Edit Todo")),
         body: Padding(
         padding: const EdgeInsets.all(0.0),
         child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add Title",
              ),
              controller: titleEdit,
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
              controller: descEdit,
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
                  Todo todo = editTodo(title, description);
                  serializeTODO(savedTodo, todos);
                  Navigator.pop(context, todo);
                }
              },
              child: const Text("save Todo"),
            ),
          ],
        ),
      ),
    );
  }

  Todo editTodo(String title, String description) {
    for(int i = 0; i < todos.length; i++) {
      if(todos[i].id == todo.id) {
        
        todo = Todo(
          title: title,
          description: description
          done: false,
          id: todo.id,
        );
      todos[i] = todo;
      break;
      }
    }
  return Todo(
    title: title,
    description: description,
    done: false,
    id: todo.id,
    );
   }
 }
