import 'package:material_ui/material_ui.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get _theme => Theme.of(this);
  TextTheme get textTheme => _theme.textTheme;
  ColorScheme get colorScheme => _theme.colorScheme;
  Size get deviceSize => MediaQuery.sizeOf(this);
}
