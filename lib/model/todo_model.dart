import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TodoModel extends Equatable {
  int? id;
  String todo;
  bool isCompleted;
  DateTime createdAt;

  TodoModel({
    this.id,
    required this.todo,
    required this.isCompleted,
    required this.createdAt,
  });

  factory TodoModel.init() => TodoModel(
        todo: '',
        isCompleted: false,
        createdAt: DateTime.now(),
      );

  TodoModel copyWith({
    int? id,
    String? todo,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return TodoModel(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todo': todo,
      'isCompleted': isCompleted ? "1" : "0",
      'createdAt': createdAt.millisecondsSinceEpoch.toString(),
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id']?.toInt(),
      todo: map['todo'] ?? '',
      isCompleted: map['isCompleted'] == "1",
      createdAt:
          DateTime.fromMillisecondsSinceEpoch(int.parse(map['createdAt'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TodoModel(id: $id, todo: $todo, isCompleted: $isCompleted, createdAt: $createdAt)';
  }

  @override
  List<Object> get props => [id!, todo, isCompleted, createdAt];
}
