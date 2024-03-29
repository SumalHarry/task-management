import 'package:flutter/material.dart';
import 'package:flutter_project/features/pin_code/presentation/widgets/widget_pin_code.dart';
import 'package:flutter_project/shared/theme/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Numpad extends ConsumerWidget {
  const Numpad({
    super.key,
    this.buttonSize = 70,
    required this.onPressedNumber,
    required this.onPressedDelete,
  });

  final double buttonSize;
  final ValueSetter<int> onPressedNumber;
  final VoidCallback onPressedDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        /// 1-9 digits
        for (var i = 0; i < 3; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                3,
                (index) => NumberButton(
                  buttonSize: buttonSize,
                  number: 1 + 3 * i + index,
                  onPressed: (value) => onPressedNumber(value),
                ),
              ).toList(),
            ),
          ),

        /// 0 digit with back remove
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const TextButton(onPressed: null, child: SizedBox()),
              NumberButton(
                buttonSize: buttonSize,
                number: 0,
                onPressed: (value) => onPressedNumber(value),
              ),
              TextButton(
                onPressed: onPressedDelete,
                child: const Icon(
                  Icons.backspace,
                  color: AppColors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
