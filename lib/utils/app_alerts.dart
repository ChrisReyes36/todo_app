import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/utils.dart';

enum AlertType { success, error, info }

@immutable
class AppAlerts {
  const AppAlerts._();

  static OverlayEntry? _current;

  static void showToast(
    BuildContext context,
    String message, {
    AlertType type = AlertType.success,
  }) {
    final overlay = Overlay.of(context, rootOverlay: true);
    _current?.remove();

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _TopToast(
        message: message,
        type: type,
        onDismissed: () {
          entry.remove();
          if (_current == entry) _current = null;
        },
      ),
    );
    _current = entry;
    overlay.insert(entry);
  }

  static Future<void> showAlertDeleteDialog({
    required BuildContext context,
    required WidgetRef ref,
    required Task task,
  }) async {
    final cancelButton = TextButton(
      child: const Text('NO'),
      onPressed: () => context.pop(),
    );
    final deleteButton = TextButton(
      onPressed: () async {
        await ref.read(taskProvider.notifier).deleteTask(task);
        if (!context.mounted) return;
        showToast(context, 'Task deleted successfully');
        context.pop();
      },
      child: const Text('YES'),
    );

    final alert = AlertDialog(
      title: const Text('Are you sure you want to delete this task?'),
      actions: [deleteButton, cancelButton],
    );

    await showDialog(context: context, builder: (BuildContext context) => alert);
  }
}

class _TopToast extends StatefulWidget {
  const _TopToast({
    required this.message,
    required this.type,
    required this.onDismissed,
  });

  final String message;
  final AlertType type;
  final VoidCallback onDismissed;

  @override
  State<_TopToast> createState() => _TopToastState();
}

class _TopToastState extends State<_TopToast>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller.forward();
    _timer = Timer(const Duration(seconds: 3), _dismiss);
  }

  Future<void> _dismiss() async {
    _timer?.cancel();
    if (!mounted) return;
    await _controller.reverse();
    widget.onDismissed();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final (background, foreground, icon) = switch (widget.type) {
      AlertType.success => (
        Colors.green.shade600,
        Colors.white,
        Icons.check_circle_rounded,
      ),
      AlertType.error => (
        colors.error,
        colors.onError,
        Icons.error_rounded,
      ),
      AlertType.info => (
        Colors.blue.shade700,
        Colors.white,
        Icons.info_rounded,
      ),
    };

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1.5),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
            ),
            child: FadeTransition(
              opacity: _controller,
              child: GestureDetector(
                onTap: _dismiss,
                onVerticalDragEnd: (_) => _dismiss(),
                child: Material(
                  color: background,
                  elevation: 6,
                  borderRadius: BorderRadius.circular(14),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Icon(icon, color: foreground),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            widget.message,
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: foreground,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
