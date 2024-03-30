import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/features/pin_code/presentation/porviders/state/pin_code_state.dart';
import 'package:flutter_project/features/pin_code/presentation/widgets/widget_pin_code.dart';
import 'package:flutter_project/features/pin_code_editing/presentation/porviders/pin_code_editing_providers.dart';
import 'package:flutter_project/features/pin_code_editing/presentation/porviders/state/pin_code_editing_state.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_project/shared/theme/app_colors.dart';
import 'package:flutter_project/shared/widgets/app_activity/presentation/widgets/app_activity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class PinCodeEditingScreen extends ConsumerStatefulWidget {
  const PinCodeEditingScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PinCodeEditingScreenState();
}

class _PinCodeEditingScreenState extends ConsumerState<PinCodeEditingScreen> {
  final double buttonSize = 70.0;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(pinCodeEditingNotifierProvider.notifier);
    final state = ref.watch(pinCodeEditingNotifierProvider);

    ref.listen(
      pinCodeEditingNotifierProvider.select((value) => value),
      ((previous, next) {
        if (next.state == PinCodeConcreteState.success &&
            next.editingState == PinCodeEditingConcreteState.success) {
          AutoRouter.of(context).pop();
        } else if (next.state == PinCodeConcreteState.failure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(next.message.toString())));
        }
      }),
    );

    String title = state.editingState.title;
    BoxDecoration decorationLinearGradient = BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Theme.of(context).colorScheme.secondary,
          Theme.of(context).colorScheme.primary,
        ],
      ),
    );

    return AppActivity(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          centerTitle: true,
          flexibleSpace: DecoratedBox(
            decoration: decorationLinearGradient,
            child: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Container(
                padding: const EdgeInsets.only(bottom: 25.0),
                decoration: decorationLinearGradient,
              ),
            ),
          ),
        ),
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
      ),
    );
  }
}
