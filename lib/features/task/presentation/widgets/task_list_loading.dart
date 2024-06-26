import 'package:flutter/material.dart';
import 'package:flutter_project/features/task/presentation/widgets/task_list_item.dart';
import 'package:flutter_project/shared/domain/models/task/task_model.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TaskListLoading extends ConsumerWidget {
  const TaskListLoading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: HORIZON_PADDING,
                  right: HORIZON_PADDING,
                ),
                child: Text(List.generate(10, (index) => '-').join('')),
              ),
              Column(
                children: List.generate(
                  1,
                  (indexItem) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: HORIZON_PADDING),
                    child: TaskListItem(
                      task: Task(
                        id: List.generate(10, (index) => '-').join(''),
                        title: List.generate(30, (index) => '-').join(''),
                        description: List.generate(20, (index) => '-').join(''),
                        createdAt: List.generate(30, (index) => '-').join(''),
                        status: List.generate(30, (index) => '-').join(''),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
