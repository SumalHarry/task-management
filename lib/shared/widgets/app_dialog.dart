import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppDialog extends ConsumerWidget {
  const AppDialog({
    super.key,
    this.title = "",
    this.content = "",
    this.confirm,
    this.cancel = "Close",
    this.onConfirm,
  });

  final String title;
  final String content;
  final String? confirm;
  final String cancel;
  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        if (confirm != null && confirm!.isNotEmpty)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              if (onConfirm != null) onConfirm!.call();
            },
            child: Text(confirm!),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancel),
        ),
      ],
    );
  }
}
