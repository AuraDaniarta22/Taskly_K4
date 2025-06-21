class Task {
  String id;
  String title;
  DateTime dueDate;
  DateTime? dueTime; // Nullable for tasks without a specific time
  bool isCompleted;
  String? notes; // Optional notes for the task

  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    this.dueTime,
    this.isCompleted = false,
    this.notes,
  });

  // Factory constructor to create a Task from a Map (e.g., from JSON/database)
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      dueDate: DateTime.parse(map['dueDate']),
      dueTime: map['dueTime'] != null ? DateTime.parse(map['dueTime']) : null,
      isCompleted: map['isCompleted'] ?? false,
      notes: map['notes'],
    );
  }

  // Convert Task object to a Map (e.g., for JSON/database storage)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'dueDate': dueDate.toIso8601String(),
      'dueTime': dueTime?.toIso8601String(),
      'isCompleted': isCompleted,
      'notes': notes,
    };
  }
}