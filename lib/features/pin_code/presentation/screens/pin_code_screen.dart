import 'package:flutter/material.dart';
import 'package:flutter_project/features/pin_code/presentation/porviders/pin_code_providers.dart';
import 'package:flutter_project/features/pin_code/presentation/porviders/state/pin_code_state.dart';
import 'package:flutter_project/features/pin_code/presentation/widgets/widget_pin_code.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_project/shared/theme/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PinCodeScreen extends ConsumerStatefulWidget {
  static const routeName = '/pinCodeScreen';

  const PinCodeScreen({super.key, required this.onVerified});
  final VoidCallback onVerified;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends ConsumerState<PinCodeScreen> {
  final double buttonSize = 70.0;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(pinCodeNotifierProvider.notifier);
    final state = ref.watch(pinCodeNotifierProvider);

    ref.listen(
      pinCodeNotifierProvider.select((value) => value),
      ((previous, next) {
        if (next.state == PinCodeConcreteState.success) {
          widget.onVerified();
        } else if (next.state == PinCodeConcreteState.failure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(next.message.toString())));
        }
      }),
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.secondary,
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(),
              const Center(
                child: Text(
                  'Security Pin',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
              const SizedBox(height: 50),

              /// pin code area
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  PIN_LENGTH,
                  (index) {
                    return Container(
                      margin: const EdgeInsets.all(6.0),
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index < state.enteredPin.length
                            ? Theme.of(context).primaryColor
                            : Colors.white24,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Numpad(
                buttonSize: buttonSize,
                onPressedNumber: (value) => notifier.addPinNumber(value),
                onPressedDelete: () => notifier.removePinNumber(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
