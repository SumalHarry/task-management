//test for filename
import 'package:flutter_project/features/task/domain/repository/task_repository.dart';
import 'package:flutter_project/features/task/presentation/providers/state/task_notifier.dart';
import 'package:flutter_project/features/task/presentation/providers/state/task_state.dart';
import 'package:flutter_project/shared/domain/models/either.dart';
import 'package:flutter_project/shared/domain/models/task/task_status.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

import '../../../../fixtures/dashboard/dummy_tasklist.dart';
import '../../../../fixtures/dummy_data.dart';

void main() {
  late TaskRepository taskRepository;
  late TaskNotifier notifier;
  final taskStatus = TaskStatus.TODO.value;
  setUpAll(() {
    taskRepository = MockTaskRepository();
    notifier = TaskNotifier(taskRepository, taskStatus);
  });
  stateNotifierTest<TaskNotifier, TaskState>(
    'Should fail when error occurs on fetch',
    build: () => TaskNotifier(taskRepository, taskStatus),
    setUp: () {
      when(() => taskRepository.getTasks(
            offset: 0,
            limit: ITEMS_PER_PAGE,
            sortBy: CREATE_AT,
            isAsc: true,
            status: taskStatus,
          )).thenAnswer(
        (invocation) async => Left(ktestAppException),
      );
    },
    actions: (notifier) async {
      await notifier.fetchTask();
    },
    expect: () => [
      TaskState(
        state: TaskConcreteState.loading,
        page: 0,
        total: 0,
        hasData: false,
        taskStatus: taskStatus,
      ),
      TaskState(
        state: TaskConcreteState.failure,
        taskList: const [],
        page: 0,
        total: 0,
        hasData: false,
        taskStatus: taskStatus,
      ),
    ],
  );
  stateNotifierTest<TaskNotifier, TaskState>(
    'Should load list of task on successful fetch',
    build: () => TaskNotifier(taskRepository, taskStatus),
    setUp: () {
      when(() => taskRepository.getTasks(
            offset: 0,
            limit: ITEMS_PER_PAGE,
            sortBy: CREATE_AT,
            isAsc: true,
            status: taskStatus,
          )).thenAnswer(
        (invocation) async => Right(ktestPaginatedResponse()),
      );
    },
    actions: (notifier) async {
      await notifier.fetchTask();
    },
    expect: () => [
      TaskState(
        state: TaskConcreteState.loading,
        taskStatus: taskStatus,
      ),
      TaskState(
        state: TaskConcreteState.loaded,
        hasData: true,
        taskList: ktestTaskList,
        page: 1,
        total: 100,
        taskStatus: taskStatus,
      ),
    ],
  );
  stateNotifierTest<TaskNotifier, TaskState>(
    'Should have taskList of previous fetch when error occurs on second page',
    build: () => TaskNotifier(taskRepository, taskStatus),
    setUp: () {
      when(() => taskRepository.getTasks(
            offset: 0,
            limit: ITEMS_PER_PAGE,
            sortBy: CREATE_AT,
            isAsc: true,
            status: taskStatus,
          )).thenAnswer(
        (invocation) async => Right(ktestPaginatedResponse()),
      );
      when(() => taskRepository.getTasks(
            offset: 1,
            limit: ITEMS_PER_PAGE,
            sortBy: CREATE_AT,
            isAsc: true,
            status: taskStatus,
          )).thenAnswer(
        (invocation) async => Left(ktestAppException),
      );
    },
    actions: (notifier) async {
      await notifier.fetchTask();
      await notifier.fetchTask();
    },
    expect: () => [
      TaskState(
        state: TaskConcreteState.loading,
        taskStatus: taskStatus,
      ),
      TaskState(
        state: TaskConcreteState.loaded,
        taskList: ktestTaskList,
        taskStatus: taskStatus,
        page: 1,
        total: 100,
        hasData: true,
      ),
      TaskState(
        state: TaskConcreteState.fetchingMore,
        taskList: ktestTaskList,
        taskStatus: taskStatus,
        page: 1,
        total: 100,
        hasData: true,
      ),
      TaskState(
        state: TaskConcreteState.failure,
        taskList: ktestTaskList,
        taskStatus: taskStatus,
        page: 1,
        total: 100,
        hasData: true,
      ),
    ],
  );

  stateNotifierTest<TaskNotifier, TaskState>(
    'Should increment page and append task response to the taskList on successive fetch',
    build: () => TaskNotifier(taskRepository, taskStatus),
    setUp: () {
      when(() => taskRepository.getTasks(
            offset: 0,
            limit: ITEMS_PER_PAGE,
            sortBy: CREATE_AT,
            isAsc: true,
            status: taskStatus,
          )).thenAnswer(
        (invocation) async => Right(ktestPaginatedResponse()),
      );
      when(() => taskRepository.getTasks(
            offset: 1,
            limit: ITEMS_PER_PAGE,
            sortBy: CREATE_AT,
            isAsc: true,
            status: taskStatus,
          )).thenAnswer(
        (invocation) async => Right(ktestPaginatedResponse(pageNumber: 1)),
      );
    },
    actions: (notifier) async {
      await notifier.fetchTask();
      await notifier.fetchTask();
    },
    expect: () => [
      TaskState(
        state: TaskConcreteState.loading,
        taskStatus: taskStatus,
      ),
      TaskState(
        state: TaskConcreteState.loaded,
        taskList: ktestTaskList,
        taskStatus: taskStatus,
        page: 1,
        total: 100,
        hasData: true,
      ),
      TaskState(
        state: TaskConcreteState.fetchingMore,
        hasData: true,
        page: 1,
        total: 100,
        taskList: ktestTaskList,
        taskStatus: taskStatus,
      ),
      TaskState(
        state: TaskConcreteState.loaded,
        taskList: [...ktestTaskList, ...ktestTaskList],
        page: 2,
        total: 100,
        hasData: true,
        taskStatus: taskStatus,
      ),
    ],
  );

  test('Should reset state to initial', () {
    notifier.resetState();

    // ignore: invalid_use_of_protected_member
    expect(notifier.state, TaskState.initial(taskStatus: taskStatus));
  });
}

class MockTaskRepository extends Mock implements TaskRepository {}
