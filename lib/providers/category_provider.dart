import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/utils/utils.dart';

class CategoryNotifier extends Notifier<TaskCategory> {
  @override
  TaskCategory build() => TaskCategory.others;

  void setCategory(TaskCategory category) => state = category;
}

final categoryProvider =
    NotifierProvider.autoDispose<CategoryNotifier, TaskCategory>(
      CategoryNotifier.new,
    );
