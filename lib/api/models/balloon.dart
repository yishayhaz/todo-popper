import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum BalloonImportance { low, medium, high }

class BalloonModal {
  final String id;

  final String title;
  final String description;
  final bool isDone;

  final DateTime createdAt;
  final DateTime dueDate;

  final BalloonImportance importance;
  final Color color;
  final double top;
  final double left;

  BalloonModal({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.createdAt,
    required this.dueDate,
    required this.importance,
    required this.color,
    required this.top,
    required this.left,
  });

  factory BalloonModal.fromJson(Map<dynamic, dynamic> json) {
    return BalloonModal(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isDone: json['isDone'],
      createdAt: DateTime.parse(json['createdAt']),
      dueDate: DateTime.parse(json['dueDate']),
      importance: BalloonImportance.values.firstWhere(
        (e) => e.toString() == json['importance'],
      ),
      color: Color(int.parse(json['color'])),
      top: json['top'],
      left: json['left'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'createdAt': createdAt.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'importance': importance.toString(),
      'color': color.value.toString(),
      'top': top,
      'left': left,
    };
  }

  BalloonModal copyWith({
    String? id,
    String? title,
    String? description,
    bool? isDone,
    DateTime? createdAt,
    DateTime? dueDate,
    BalloonImportance? importance,
    Color? color,
    double? top,
    double? left,
  }) {
    return BalloonModal(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      importance: importance ?? this.importance,
      color: color ?? this.color,
      top: top ?? this.top,
      left: left ?? this.left,
    );
  }

  static List<BalloonModal> readManyFromBox(Box box) {
    return box.values
        .map((e) => BalloonModal.fromJson(e))
        .where((element) =>
            element.isDone == false &&
            element.dueDate.day == DateTime.now().day &&
            element.dueDate.month == DateTime.now().month &&
            element.dueDate.year == DateTime.now().year)
        .toList()
      ..sort((a, b) => b.importance.index.compareTo(a.importance.index));
  }
}
