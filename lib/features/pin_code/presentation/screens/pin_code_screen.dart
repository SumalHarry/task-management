import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/features/pin_code/presentation/porviders/pin_code_providers.dart';
import 'package:flutter_project/features/pin_code/presentation/porviders/state/pin_code_state.dart';
import 'package:flutter_project/features/pin_code/presentation/widgets/widget_pin_code.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_project/shared/theme/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class PinCodeScreen extends ConsumerStatefulWidget {
  static const routeName = '/pinCodeScreen';

  const PinCodeScreen({super.key, this.onVerified});
  final VoidCallback? onVerified;

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
          if (widget.onVerified != null) widget.onVerified!();
          notifier.resetState();
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
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.primary,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(),
              Center(
                child: Text(
                  'Security Pin',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.surface,
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
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outline,
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
