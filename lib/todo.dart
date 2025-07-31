class Todo {
  String title;
  String description;
  bool done;

  Todo({
    required this.title,
    required this.description,
    required this.done,
  });

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        done = json['done'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'done': done,
    };
  }
}
