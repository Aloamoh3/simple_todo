import 'package:flutter/material.dart';
import 'package:simple_todo/edit_todo.dart';
import 'package:simple_todo/todo.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

late Todo todo;

@override
void initState() {
  super.initState();
  todo = ModalRoute.of(context)!.settings.arguments as Todo;
}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(appBar: AppBar(title: Text(todo.title),),
    body: Padding(
      padding: const EdgeInsets.all(16),
       child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(todo.description),
        ElevatedButton(onPressed: () {
          Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditTodo(),
                        settings: RouteSettings(arguments: todo),
                      ),
                    );
        }, child: Text("Edit Todo"),
            ),
       ]),
     ),
    );
  }
}
