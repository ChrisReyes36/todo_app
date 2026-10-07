import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_app/app/todo_app.dart';

void main() {
  runApp(const ProviderScope(child: TodoApp()));
}
