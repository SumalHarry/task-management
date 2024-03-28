import 'package:equatable/equatable.dart';
import 'package:flutter_project/shared/domain/models/task/task_model.dart';

enum TaskConcreteState {
  initial,
  loading,
  loaded,
  failure,
  fetchingMore,
  fetchedAllProducts
}

class TaskState extends Equatable {
  final String taskStatus;
  final TaskList taskList;
  final Map<String, TaskList> groupedTasks;
  final int total;
  final int page;
  final bool hasData;
  final TaskConcreteState state;
  final String message;
  final bool isLoading;
  const TaskState({
    required this.taskStatus,
    this.taskList = const [],
    this.groupedTasks = const {},
    this.isLoading = false,
    this.hasData = false,
    this.state = TaskConcreteState.initial,
    this.message = '',
    this.page = 0,
    this.total = 0,
  });

  const TaskState.initial({
    required this.taskStatus,
    this.taskList = const [],
    this.groupedTasks = const {},
    this.total = 0,
    this.page = 0,
    this.isLoading = false,
    this.hasData = false,
    this.state = TaskConcreteState.initial,
    this.message = '',
  });

  TaskState copyWith({
    TaskList? taskList,
    Map<String, TaskList>? groupedTasks,
    int? total,
    int? page,
    bool? hasData,
    TaskConcreteState? state,
    String? message,
    bool? isLoading,
  }) {
    return TaskState(
      taskStatus: taskStatus,
      taskList: taskList ?? this.taskList,
      groupedTasks: groupedTasks ?? this.groupedTasks,
      total: total ?? this.total,
      page: page ?? this.page,
      hasData: hasData ?? this.hasData,
      state: state ?? this.state,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() {
    return 'TaskState{taskList: $taskList, page: $page, hasData: $hasData, state: $state, message: $message}';
  }

  @override
  List<Object?> get props => [taskList, page, hasData, state, message];
}
