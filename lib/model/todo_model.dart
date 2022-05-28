import 'dart:convert';

import 'package:equatable/equatable.dart';

const String tableTodo = 'todo';
const String columnId = '_id';
const String columnTitle = 'title';
const String columnCreatedAt = 'createdAt';
const String columnIsCompleted = 'isCompleted';
const String columnColor = 'color';

// ignore: must_be_immutable
class TodoModel extends Equatable {
  int? id;
  final String title;
  final bool isCompleted;
  final DateTime createdAt;
  final int color;

  TodoModel({
    this.id,
    required this.title,
    required this.isCompleted,
    required this.createdAt,
    required this.color,
  });

  factory TodoModel.init() => TodoModel(
        title: '',
        isCompleted: false,
        createdAt: DateTime.now(),
        color: 0,
      );

  TodoModel copyWith({
    int? id,
    String? title,
    bool? isCompleted,
    DateTime? createdAt,
    int? color,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      columnTitle: title,
      columnIsCompleted: isCompleted ? 1 : 0,
      columnCreatedAt: createdAt.millisecondsSinceEpoch.toString(),
      columnColor: color,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map[columnId]?.toInt(),
      title: map[columnTitle],
      isCompleted: map[columnIsCompleted] == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        int.parse(
          map[columnCreatedAt].toString(),
        ),
      ),
      color: map[columnColor],
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TodoModel(id: $id, title: $title, isCompleted: $isCompleted, createdAt: $createdAt, color: $color)';
  }

  @override
  List<Object> get props {
    return [
      id!,
      title,
      isCompleted,
      createdAt,
      color,
    ];
  }
}
