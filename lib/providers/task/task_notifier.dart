import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/task/task_state.dart';

class TaskNotifier extends Notifier<TaskState> {
  late final TaskRepository _repository;

  @override
  TaskState build() {
    _repository = ref.watch(taskRepositoryProvider);
    getTasks();
    return const TaskState.initial();
  }

  Future<void> createTask(Task task) async {
    try {
      await _repository.addTask(task);
      await getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _repository.deleteTask(task);
      await getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      final isCompleted = !task.isCompleted;
      final updatedTask = task.copyWith(isCompleted: isCompleted);
      await _repository.updateTask(updatedTask);
      await getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getTasks() async {
    try {
      final tasks = await _repository.getAllTasks();
      state = state.copyWith(tasks: tasks);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

