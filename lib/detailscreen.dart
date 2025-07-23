import 'package:flutter/material.dart';
import 'package:simple_todo/todo.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments as Todo;
    return Scaffold(appBar: AppBar(title: Text(todo.title),),
    body: Padding(padding: const EdgeInsets.all(16), child: Text(todo.description),),
    );
  }
}