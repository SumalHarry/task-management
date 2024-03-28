import 'package:flutter/material.dart';
import 'package:flutter_project/features/task/presentation/providers/state/task_notifier.dart';
import 'package:flutter_project/features/task/presentation/providers/state/task_state.dart';
import 'package:flutter_project/shared/domain/models/task/task_status.dart';
import 'package:flutter_project/features/task/presentation/providers/task_state_provider.dart';
import 'package:flutter_project/features/task/presentation/widgets/task_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskList extends ConsumerStatefulWidget {
  const TaskList(
      {super.key, required this.taskStatus, this.fetchingScrollOffset = 300});

  final TaskStatus taskStatus;
  final double fetchingScrollOffset;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskListState();
}

class _TaskListState extends ConsumerState<TaskList> {
  late StateNotifierProvider<TaskNotifier, TaskState> taskNotifierProvider;
  final scrollController = ScrollController();

  @override
  void initState() {
    taskNotifierProvider = getTaskNotifierProvider(widget.taskStatus.value);
    scrollController.addListener(scrollControllerListener);

    super.initState();
  }

  void scrollControllerListener() {
    bool isFetching = ref.read(taskNotifierProvider.notifier).isFetching;
    if (!isFetching &&
        scrollController.position.extentAfter > 0 &&
        scrollController.position.extentAfter < widget.fetchingScrollOffset) {
      ref.read(taskNotifierProvider.notifier).fetchTask();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(taskNotifierProvider);
    final notifier = ref.read(taskNotifierProvider.notifier);
    final groupedTasks = state.groupedTasks;
    final groupedTaskKeys = groupedTasks.keys.toList();
    final groupedTaskValues = groupedTasks.values.toList();

    return state.state == TaskConcreteState.loading
        ? const Center(child: CircularProgressIndicator()) // TODO: Add skeleton
        : state.hasData
            ? Column(children: [
                Expanded(
                  child: Scrollbar(
                    controller: scrollController,
                    child: ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(8),
                      itemCount:
                          groupedTaskKeys.length + (notifier.hasMore ? 1 : 0),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == groupedTaskKeys.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: SizedBox(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        }

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
                // if (state.state == TaskConcreteState.fetchingMore)
                //   const Padding(
                //     padding: EdgeInsets.symmetric(vertical: 16.0),
                //     child: CircularProgressIndicator(),
                //   ),
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
