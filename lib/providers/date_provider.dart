import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateNotifier extends Notifier<DateTime> {
  @override
  DateTime build() => DateTime.now();

  void setDate(DateTime date) => state = date;
}

final dateProvider = NotifierProvider<DateNotifier, DateTime>(
  DateNotifier.new,
);
