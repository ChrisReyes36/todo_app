import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/task/task_notifier.dart';
import 'package:todo_app/providers/task/task_state.dart';

final taskProvider = NotifierProvider<TaskNotifier, TaskState>(
  TaskNotifier.new,
);
