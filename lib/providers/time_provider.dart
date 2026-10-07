import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class TimeNotifier extends Notifier<TimeOfDay> {
  @override
  TimeOfDay build() => TimeOfDay.now();

  void setTime(TimeOfDay time) => state = time;
}

final timeProvider = NotifierProvider<TimeNotifier, TimeOfDay>(
  TimeNotifier.new,
);
