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
  // stateNotifierTest<TaskNotifier, TaskState>(
  //   'Should load list of products on successful fetch',
  //   build: () => TaskNotifier(taskRepository),
  //   setUp: () {
  //     when(() => taskRepository.fetchProducts(skip: 0)).thenAnswer(
  //       (invocation) async => Right(ktestPaginatedResponse()),
  //     );
  //   },
  //   actions: (notifier) async {
  //     await notifier.fetchProducts();
  //   },
  //   expect: () => [
  //     const TaskState(
  //       state: TaskConcreteState.loading,
  //     ),
  //     TaskState(
  //       state: TaskConcreteState.loaded,
  //       hasData: true,
  //       productList: ktestProductList,
  //       page: 1,
  //       total: 100,
  //     ),
  //   ],
  // );
  // stateNotifierTest<TaskNotifier, TaskState>(
  //   'Should have productList of previous fetch when error occurs on second page',
  //   build: () => TaskNotifier(taskRepository),
  //   setUp: () {
  //     when(() => taskRepository.fetchProducts(skip: 0)).thenAnswer(
  //       (invocation) async => Right(ktestPaginatedResponse()),
  //     );
  //     when(() => taskRepository.fetchProducts(skip: PRODUCTS_PER_PAGE))
  //         .thenAnswer(
  //       (invocation) async => Left(ktestAppException),
  //     );
  //   },
  //   actions: (notifier) async {
  //     await notifier.fetchProducts();
  //     await notifier.fetchProducts();
  //   },
  //   expect: () => [
  //     const TaskState(
  //       state: TaskConcreteState.loading,
  //     ),
  //     TaskState(
  //       state: TaskConcreteState.loaded,
  //       hasData: true,
  //       productList: ktestProductList,
  //       page: 1,
  //       total: 100,
  //     ),
  //     TaskState(
  //       state: TaskConcreteState.fetchingMore,
  //       hasData: true,
  //       productList: ktestProductList,
  //       page: 1,
  //       total: 100,
  //     ),
  //     TaskState(
  //       state: TaskConcreteState.failure,
  //       page: 1,
  //       total: 100,
  //       hasData: true,
  //       productList: ktestProductList,
  //     ),
  //   ],
  // );

  // stateNotifierTest<TaskNotifier, TaskState>(
  //   'Should increment page and append product response to the productList on successive fetch',
  //   build: () => TaskNotifier(taskRepository),
  //   setUp: () {
  //     when(() => taskRepository.fetchProducts(skip: 0)).thenAnswer(
  //       (invocation) async => Right(ktestPaginatedResponse()),
  //     );
  //     when(() => taskRepository.fetchProducts(skip: PRODUCTS_PER_PAGE))
  //         .thenAnswer(
  //       (invocation) async =>
  //           Right(ktestPaginatedResponse(skip: PRODUCTS_PER_PAGE)),
  //     );
  //   },
  //   actions: (notifier) async {
  //     await notifier.fetchProducts();
  //     await notifier.fetchProducts();
  //   },
  //   expect: () => [
  //     const TaskState(
  //       state: TaskConcreteState.loading,
  //       page: 0,
  //       total: 0,
  //       hasData: false,
  //     ),
  //     TaskState(
  //       state: TaskConcreteState.loaded,
  //       productList: ktestProductList,
  //       page: 1,
  //       total: 100,
  //       hasData: true,
  //     ),
  //     TaskState(
  //       state: TaskConcreteState.fetchingMore,
  //       hasData: true,
  //       page: 1,
  //       total: 100,
  //       productList: ktestProductList,
  //     ),
  //     TaskState(
  //       state: TaskConcreteState.loaded,
  //       productList: [...ktestProductList, ...ktestProductList],
  //       page: 2,
  //       total: 100,
  //       hasData: true,
  //     ),
  //   ],
  // );
  // group('Task Search state', () {
  //   stateNotifierTest<TaskNotifier, TaskState>(
  //     'Should fail when error occurs on fetch',
  //     build: () => TaskNotifier(taskRepository),
  //     setUp: () {
  //       when(() => taskRepository.searchProducts(skip: 0, query: ''))
  //           .thenAnswer(
  //         (invocation) async => Left(ktestAppException),
  //       );
  //     },
  //     actions: (notifier) async {
  //       await notifier.searchProducts('');
  //     },
  //     expect: () => [
  //       const TaskState(
  //         state: TaskConcreteState.loading,
  //         page: 0,
  //         total: 0,
  //         hasData: false,
  //       ),
  //       const TaskState(
  //         state: TaskConcreteState.failure,
  //         productList: [],
  //         page: 0,
  //         total: 0,
  //         hasData: false,
  //       ),
  //     ],
  //   );
  //   stateNotifierTest<TaskNotifier, TaskState>(
  //     'Should load list of products on successful fetch',
  //     build: () => TaskNotifier(taskRepository),
  //     setUp: () {
  //       when(() => taskRepository.searchProducts(skip: 0, query: ''))
  //           .thenAnswer(
  //         (invocation) async => Right(ktestPaginatedResponse()),
  //       );
  //     },
  //     actions: (notifier) async {
  //       await notifier.searchProducts('');
  //     },
  //     expect: () => [
  //       const TaskState(
  //         state: TaskConcreteState.loading,
  //       ),
  //       TaskState(
  //         state: TaskConcreteState.loaded,
  //         hasData: true,
  //         productList: ktestProductList,
  //         page: 1,
  //         total: 100,
  //       ),
  //     ],
  //   );
  //   stateNotifierTest<TaskNotifier, TaskState>(
  //     'Should have productList of previous fetch when error occurs on second page',
  //     build: () => TaskNotifier(taskRepository),
  //     setUp: () {
  //       when(() => taskRepository.searchProducts(skip: 0, query: ''))
  //           .thenAnswer(
  //         (invocation) async => Right(ktestPaginatedResponse()),
  //       );
  //       when(() => taskRepository.searchProducts(
  //           skip: PRODUCTS_PER_PAGE, query: '')).thenAnswer(
  //         (invocation) async => Left(ktestAppException),
  //       );
  //     },
  //     actions: (notifier) async {
  //       await notifier.searchProducts('');
  //       await notifier.searchProducts('');
  //     },
  //     expect: () => [
  //       const TaskState(
  //         state: TaskConcreteState.loading,
  //       ),
  //       TaskState(
  //         state: TaskConcreteState.loaded,
  //         hasData: true,
  //         productList: ktestProductList,
  //         page: 1,
  //         total: 100,
  //       ),
  //       TaskState(
  //         state: TaskConcreteState.fetchingMore,
  //         hasData: true,
  //         productList: ktestProductList,
  //         page: 1,
  //         total: 100,
  //       ),
  //       TaskState(
  //         state: TaskConcreteState.failure,
  //         page: 1,
  //         total: 100,
  //         hasData: true,
  //         productList: ktestProductList,
  //       ),
  //     ],
  //   );

  //   stateNotifierTest<TaskNotifier, TaskState>(
  //     'Should increment page and append product response to the productList on successive fetch',
  //     build: () => TaskNotifier(taskRepository),
  //     setUp: () {
  //       when(() => taskRepository.searchProducts(skip: 0, query: ''))
  //           .thenAnswer(
  //         (invocation) async => Right(ktestPaginatedResponse()),
  //       );
  //       when(() => taskRepository.searchProducts(
  //           skip: PRODUCTS_PER_PAGE, query: '')).thenAnswer(
  //         (invocation) async =>
  //             Right(ktestPaginatedResponse(skip: PRODUCTS_PER_PAGE)),
  //       );
  //     },
  //     actions: (notifier) async {
  //       await notifier.searchProducts('');
  //       await notifier.searchProducts('');
  //     },
  //     expect: () => [
  //       const TaskState(
  //         state: TaskConcreteState.loading,
  //         page: 0,
  //         total: 0,
  //         hasData: false,
  //       ),
  //       TaskState(
  //         state: TaskConcreteState.loaded,
  //         productList: ktestProductList,
  //         page: 1,
  //         total: 100,
  //         hasData: true,
  //       ),
  //       TaskState(
  //         state: TaskConcreteState.fetchingMore,
  //         hasData: true,
  //         page: 1,
  //         total: 100,
  //         productList: ktestProductList,
  //       ),
  //       TaskState(
  //         state: TaskConcreteState.loaded,
  //         productList: [...ktestProductList, ...ktestProductList],
  //         page: 2,
  //         total: 100,
  //         hasData: true,
  //       ),
  //     ],
  //   );
  // });
  // group('When the fetch is called while loading', () {
  //   stateNotifierTest<TaskNotifier, TaskState>(
  //     'Should not load list of products when it is already loading while search',
  //     build: () => TaskNotifier(taskRepository),
  //     setUp: () {
  //       when(() => taskRepository.searchProducts(skip: 0, query: ''))
  //           .thenAnswer(
  //         (invocation) async => Right(ktestPaginatedResponse()),
  //       );
  //     },
  //     actions: (notifier) async {
  //       notifier.searchProducts('');
  //       notifier.searchProducts('');
  //     },
  //     expect: () => [
  //       const TaskState(
  //         isLoading: true,
  //         productList: [],
  //         hasData: false,
  //         state: TaskConcreteState.loading,
  //       ),
  //       const TaskState(
  //         isLoading: false,
  //         productList: [],
  //         total: 0,
  //         page: 0,
  //         hasData: false,
  //         state: TaskConcreteState.fetchedAllProducts,
  //         message: 'No more products available',
  //       ),
  //       TaskState(
  //         isLoading: false,
  //         productList: ktestProductList,
  //         total: 100,
  //         page: 1,
  //         hasData: true,
  //         state: TaskConcreteState.loaded,
  //       )
  //     ],
  //   );
  //   stateNotifierTest<TaskNotifier, TaskState>(
  //     'Should not load list of products when it is already loading while fetch',
  //     build: () => TaskNotifier(taskRepository),
  //     setUp: () {
  //       when(() => taskRepository.fetchProducts(skip: 0)).thenAnswer(
  //         (invocation) async => Right(ktestPaginatedResponse()),
  //       );
  //     },
  //     actions: (notifier) async {
  //       notifier.fetchProducts();
  //       notifier.fetchProducts();
  //     },
  //     expect: () => [
  //       const TaskState(
  //         isLoading: true,
  //         productList: [],
  //         hasData: false,
  //         state: TaskConcreteState.loading,
  //       ),
  //       const TaskState(
  //         isLoading: false,
  //         productList: [],
  //         total: 0,
  //         page: 0,
  //         hasData: false,
  //         state: TaskConcreteState.fetchedAllProducts,
  //         message: 'No more products available',
  //       ),
  //       TaskState(
  //         isLoading: false,
  //         productList: ktestProductList,
  //         total: 100,
  //         page: 1,
  //         hasData: true,
  //         state: TaskConcreteState.loaded,
  //       )
  //     ],
  //   );
  // });
  test('Should reset state to initial', () {
    notifier.resetState();

    // ignore: invalid_use_of_protected_member
    expect(notifier.state, TaskState.initial(taskStatus: taskStatus));
  });
}

class MockTaskRepository extends Mock implements TaskRepository {}
