import 'package:flutter_project/features/task/domain/repository/task_repository.dart';
import 'package:flutter_project/features/task/presentation/providers/state/task_state.dart';
import 'package:flutter_project/shared/domain/models/either.dart';
import 'package:flutter_project/shared/domain/models/task/task_model.dart';
import 'package:flutter_project/shared/domain/models/paginated_response.dart';
import 'package:flutter_project/shared/exceptions/http_exception.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  final TaskRepository taskRepository;
  final String taskStatus;

  TaskNotifier(
    this.taskRepository,
    this.taskStatus,
  ) : super(TaskState.initial(taskStatus: taskStatus));

  bool get isFetching =>
      state.state == TaskConcreteState.loading ||
      state.state == TaskConcreteState.fetchingMore;

  bool get hasMore => state.state != TaskConcreteState.fetchedAllProducts;

  Future<void> fetchTask() async {
    if (isFetching) return;
    if (state.state != TaskConcreteState.fetchedAllProducts) {
      state = state.copyWith(
        state: state.page > 0
            ? TaskConcreteState.fetchingMore
            : TaskConcreteState.loading,
        isLoading: true,
      );
      await Future.delayed(const Duration(milliseconds: 500));

      final response = await taskRepository.getTasks(
        offset: state.page,
        limit: ITEMS_PER_PAGE,
        sortBy: CREATE_AT,
        isAsc: true,
        status: taskStatus,
      );
      updateStateFromResponse(response);
    } else {
      state = state.copyWith(
        state: TaskConcreteState.fetchedAllProducts,
        message: 'No more task',
        isLoading: false,
      );
    }
  }

  void deleteTask(String taskId) {
    TaskList totalTasks = state.taskList;
    totalTasks.removeWhere((element) => element.id == taskId);
    final groupedTasks = groupTasksByCreateAtString(totalTasks);
    state = state.copyWith(
      taskList: totalTasks,
      groupedTasks: groupedTasks,
      hasData: true,
      message: totalTasks.isEmpty ? 'No task found' : '',
      isLoading: false,
    );
  }

  void updateStateFromResponse(
    Either<AppException, PaginatedResponse<dynamic>> response,
  ) {
    response.fold((failure) {
      state = state.copyWith(
        state: TaskConcreteState.failure,
        message: failure.message,
        isLoading: false,
      );
    }, (data) {
      final newTasks = data.data.map((e) => Task.fromJson(e)).toList();
      final totalTasks = [...state.taskList, ...newTasks];
      final groupedTasks = groupTasksByCreateAtString(totalTasks);
      state = state.copyWith(
        taskList: totalTasks,
        groupedTasks: groupedTasks,
        state: data.pageNumber == data.totalPages
            ? TaskConcreteState.fetchedAllProducts
            : TaskConcreteState.loaded,
        hasData: true,
        message: totalTasks.isEmpty ? 'No task found' : '',
        page: data.pageNumber,
        total: data.totalPages,
        isLoading: false,
      );
    });
  }

  Map<String, List<Task>> groupTasksByCreateAtString(List<Task> tasks) {
    Map<String, List<Task>> groupedTasks = {};
    for (Task task in tasks) {
      String createAtString = task.getCreateAtString();
      if (groupedTasks.containsKey(createAtString)) {
        groupedTasks[createAtString]?.add(task);
      } else {
        groupedTasks[createAtString] = [task];
      }
    }
    return groupedTasks;
  }

  void pullToRefreah() {
    resetState();
    fetchTask();
  }

  void resetState() {
    state = TaskState.initial(taskStatus: taskStatus);
  }
}
