import 'package:flutter/material.dart';
import 'package:flutter_project/features/task/presentation/providers/state/task_notifier.dart';
import 'package:flutter_project/features/task/presentation/providers/state/task_state.dart';
import 'package:flutter_project/features/task/presentation/widgets/task_list_loading.dart';
import 'package:flutter_project/shared/domain/models/task/task_status.dart';
import 'package:flutter_project/features/task/presentation/providers/task_state_provider.dart';
import 'package:flutter_project/features/task/presentation/widgets/task_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class TaskList extends ConsumerStatefulWidget {
  const TaskList(
      {super.key, required this.taskStatus, this.fetchingScrollOffset = 400});

  final TaskStatus taskStatus;
  final int fetchingScrollOffset;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskListState();
}

class _TaskListState extends ConsumerState<TaskList> {
  late StateNotifierProvider<TaskNotifier, TaskState> taskNotifierProvider;

  @override
  void initState() {
    taskNotifierProvider = getTaskNotifierProvider(widget.taskStatus.value);
    super.initState();
  }

  void _loadMore() {
    bool isFetching = ref.read(taskNotifierProvider.notifier).isFetching;
    if (!isFetching) {
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
    final isLoading = state.isLoading;
    final itemCount = groupedTaskKeys.length + (notifier.hasMore ? 1 : 0);

    return isLoading
        ? const TaskListLoading()
        : state.hasData
            ? LazyLoadScrollView(
                onEndOfPage: () => _loadMore(),
                scrollOffset: widget.fetchingScrollOffset,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: itemCount,
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
                                    task: groupedTaskValues[index][indexItem],
                                  ),
                                ),
                              ),
                      ],
                    );
                  },
                ),
              )
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
