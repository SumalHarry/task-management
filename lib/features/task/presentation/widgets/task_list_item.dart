import 'package:flutter/material.dart';
import 'package:flutter_project/shared/domain/models/task/task_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskListItem extends ConsumerWidget {
  const TaskListItem({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: const ColoredBox(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ),
      onDismissed: (DismissDirection direction) {},
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm"),
              content: const Text("Are you sure you wish to delete this item?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("DELETE")),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("CANCEL"),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        child: ListTile(
          title: Text(
            task.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            task.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: null,
        ),
      ),
    );
  }
}
