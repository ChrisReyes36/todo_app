import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/data/datasource/task_datasource.dart';

final taskDatasourceProvider = Provider<TaskDatasource>((ref) {
  return TaskDatasource();
});
