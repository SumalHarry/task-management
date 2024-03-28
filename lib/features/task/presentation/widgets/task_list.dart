import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_project/features/task/presentation/providers/state/task_notifier.dart';
import 'package:flutter_project/features/task/presentation/providers/state/task_state.dart';
import 'package:flutter_project/shared/domain/models/task/task_status.dart';
import 'package:flutter_project/features/task/presentation/providers/task_state_provider.dart';
import 'package:flutter_project/features/task/presentation/widgets/task_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskList extends ConsumerStatefulWidget {
  const TaskList({super.key, required this.taskStatus});

  final TaskStatus taskStatus;
  final double fetchingScrollOffset = 300;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskListState();
}

class _TaskListState extends ConsumerState<TaskList> {
  late StateNotifierProvider<TaskNotifier, TaskState> taskNotifierProvider;
  final scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    taskNotifierProvider = getTaskNotifierProvider(widget.taskStatus.value);
    scrollController.addListener(scrollControllerListener);
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void scrollControllerListener() {
    if (scrollController.position.extentAfter < widget.fetchingScrollOffset) {
      if ((_debounce?.isActive ?? false) == false) {
        _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 800), () {
          ref.read(taskNotifierProvider.notifier).fetchTask();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(taskNotifierProvider);
    final groupedTasks = state.groupedTasks;
    final groupedTaskKeys = groupedTasks.keys.toList();
    final groupedTaskValues = groupedTasks.values.toList();

    return state.state == TaskConcreteState.loading
        ? const Center(child: CircularProgressIndicator())
        : state.hasData
            ? Column(children: [
                Expanded(
                  child: Scrollbar(
                    controller: scrollController,
                    child: ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(8),
                      itemCount: groupedTaskKeys.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10.0,
                                left: 20.0,
                                right: 20.0,
                              ),
                              child: Text(
                                groupedTaskKeys[index],
                              ),
                            ),
                            (groupedTasks.isEmpty)
                                ? const Center(
                                    child: Text("No task available"),
                                  )
                                : Column(
                                    children: List.generate(
                                      groupedTaskValues[index].length,
                                      (indexItem) => TaskListItem(
                                        task: groupedTaskValues[index]
                                            [indexItem],
                                      ),
                                    ),
                                  ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                if (state.state == TaskConcreteState.fetchingMore)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: CircularProgressIndicator(),
                  ),
              ])
            : Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
  }
}
