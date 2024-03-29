import 'package:flutter/material.dart';
import 'package:flutter_project/shared/theme/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumberButton extends ConsumerWidget {
  const NumberButton({
    super.key,
    this.buttonSize = 70,
    required this.number,
    this.onPressed,
  });

  final double buttonSize;
  final int number;
  final ValueSetter<int>? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white24,
        ),
        child: MaterialButton(
          shape: const CircleBorder(),
          onPressed: () => onPressed?.call(number),
          child: Text(
            number.toString(),
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
