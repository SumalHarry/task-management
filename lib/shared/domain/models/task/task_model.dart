import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

typedef TaskList = List<Task>;

@freezed
class Task with _$Task {
  factory Task({
    @Default('') String id,
    @Default('') String title,
    @Default('') String description,
    @Default('') String createdAt,
    @Default('') String status,
  }) = _Task;

  factory Task.fromJson(dynamic json) => _$TaskFromJson(json);
}

extension TaskExtensions on Task {
  String getCreateAtString() {
    DateTime dateTime = DateTime.parse(createdAt);
    if (isToday(dateTime)) {
      return 'Today';
    } else if (isTomorrow(dateTime)) {
      return 'Tomorrow';
    } else {
      String formattedString = DateFormat('dd MMM yyyy').format(dateTime);
      return formattedString;
    }
  }

  bool isToday(DateTime dateTime) {
    DateTime now = DateTime.now();
    return dateTime.day == now.day &&
        dateTime.month == now.month &&
        dateTime.year == now.year;
  }

  bool isTomorrow(DateTime dateTime) {
    DateTime now = DateTime.now().add(const Duration(days: 1));
    return dateTime.day == now.day + 1 &&
        dateTime.month == now.month &&
        dateTime.year == now.year;
  }
}
