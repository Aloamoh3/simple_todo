import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:simple_todo/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> serializeTODO(List<String> savedTodo, List<Todo> todos) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  savedTodo.clear();
  for (int i = 0; i < todos.length; i++) {
    String todo = json.encode(todos[i]);
    savedTodo.add(todo);
  }
    await prefs.setStringList("todo", savedTodo);
  }


Future<List<Todo>> deserializeTodo(
  List<String> savedTodo, List<Todo> todos) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var fromMem = prefs.getStringList("todo");
 if (fromMem != null) {
  todos.clear();
  savedTodo = fromMem;
  for (int i = 0; i < savedTodo.length; i++) {
    Todo todo = Todo.fromJson(json.decode(savedTodo[i]));
      todos.add(todo);
      
  }
 }
 return todos;
}
