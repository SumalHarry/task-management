import 'package:flutter/widgets.dart';
import 'package:flutter_project/features/pin_code/presentation/screens/pin_code_screen.dart';
import 'package:flutter_project/shared/widgets/app_activity/presentation/providers/app_activity_state_providers.dart';
import 'package:flutter_project/shared/widgets/app_activity/presentation/providers/state/app_activity_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppActivity extends ConsumerStatefulWidget {
  const AppActivity({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppActivityState();
}

class _AppActivityState extends ConsumerState<AppActivity> {
  _handleUserInteraction() {
    ref.read(appActivityNotifierProvider.notifier).resetTimer();
  }

  _onVerified() {
    ref.read(appActivityNotifierProvider.notifier).onVerified();
  }

  @override
  void initState() {
    ref.read(appActivityNotifierProvider.notifier).checkIsVerifiy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppActivityConcreteState currentState =
        ref.watch(appActivityNotifierProvider).state;
    bool isActivity = currentState == AppActivityConcreteState.activity;
    return (isActivity)
        ? GestureDetector(
            child: widget.child,
            onTap: () => _handleUserInteraction(),
            onPanDown: (_) => _handleUserInteraction(),
            onScaleStart: (_) => _handleUserInteraction(),
          )
        : PinCodeScreen(onVerified: _onVerified);
  }
}
