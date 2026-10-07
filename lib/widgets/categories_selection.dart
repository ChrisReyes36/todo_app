import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/widgets/widgets.dart';

class CategoriesSelection extends ConsumerWidget {
  const CategoriesSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(categoryProvider);
    final List<TaskCategory> categories = TaskCategory.values.toList();

    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Text('Category', style: context.textTheme.titleLarge),
          const Gap(10),
          Expanded(
            child: ListView.separated(
              itemCount: categories.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
                final category = categories[index];

                return InkWell(
                  onTap: () {
                    ref.read(categoryProvider.notifier).setCategory(category);
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: CircleContainer(
                    color: category.color.withValues(alpha: 0.3),
                    borderColor: category.color,
                    child: Icon(
                      category.icon,
                      color: selectedCategory == category
                          ? context.colorScheme.primary
                          : category.color.withValues(alpha: 0.5),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Gap(8),
            ),
          ),
        ],
      ),
    );
  }
}
