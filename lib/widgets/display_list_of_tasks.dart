import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/widgets.dart';

class DisplayListOfTasks extends ConsumerWidget {
  const DisplayListOfTasks({
    super.key,
    required this.tasks,
    this.isCompletedTasks = false,
  });

  final List<Task> tasks;
  final bool isCompletedTasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    final height = isCompletedTasks
        ? deviceSize.height * 0.25
        : deviceSize.height * 0.3;
    final emptyTasksMessage = isCompletedTasks
        ? 'There is no completed task yet'
        : 'There is no task todo!';

    return CommonContainer(
      height: height,
      child: tasks.isEmpty
          ? Center(
              child: Text(
                emptyTasksMessage,
                style: context.textTheme.headlineSmall,
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              itemCount: tasks.length,
              padding: EdgeInsets.zero,
              itemBuilder: (ctx, index) {
                final task = tasks[index];
                return InkWell(
                  onLongPress: () => AppAlerts.showAlertDeleteDialog(
                    context: context,
                    ref: ref,
                    task: task,
                  ),
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      constraints: BoxConstraints.tightFor(
                        width: deviceSize.width,
                      ),
                      builder: (ctx) {
                        return TaskDetails(task: task);
                      },
                    );
                  },
                  child: TaskTile(
                    task: task,
                    onCompleted: (_) async {
                      await ref.read(taskProvider.notifier).updateTask(task);
                      if (!context.mounted) return;
                      AppAlerts.showToast(
                        context,
                        task.isCompleted
                            ? 'Task marked as pending'
                            : 'Task completed',
                        type: task.isCompleted ? AlertType.info : AlertType.success,
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(thickness: 1.5);
              },
            ),
    );
  }
}
