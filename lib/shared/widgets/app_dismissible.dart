import 'package:flutter/material.dart';
import 'package:flutter_project/shared/widgets/app_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppDissMisssiable extends ConsumerWidget {
  const AppDissMisssiable({
    super.key,
    required this.child,
    required this.onDelete,
  });

  final Widget child;
  final VoidCallback onDelete;

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
            return AppDialog(
              title: "Confirm",
              content: "Are you sure you wish to delete this item?",
              confirm: "DELETE",
              onConfirm: () => onDelete.call(),
              cancel: "CANCEL",
            );
          },
        );
      },
      child: child,
    );
  }
}
