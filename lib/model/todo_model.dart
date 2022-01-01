class Todo {
  final String todo, priority;
  bool isChecked;
  dynamic date;
  Todo({
    required this.todo,
    required this.priority,
    required this.date,
    required this.isChecked,
  });

  Todo.fromJson(Map<String, dynamic> json)
      : this.todo = json['todo'],
        this.date = json['date'],
        this.priority = json['priority'],
        this.isChecked = json['isChecked'];

  Map<String, dynamic> toJson() => {'todo': todo, 'priority': priority, 'date': date, 'isChecked': isChecked};
}
