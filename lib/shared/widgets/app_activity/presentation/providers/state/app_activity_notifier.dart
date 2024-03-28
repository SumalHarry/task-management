import 'dart:async';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_project/shared/widgets/app_activity/domain/repositories/app_activity_repository.dart';
import 'package:flutter_project/shared/widgets/app_activity/presentation/providers/state/app_activity_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppActivityNotifier extends StateNotifier<AppActivityState> {
  final AppActivityRepository appActivityRepository;

  AppActivityNotifier({
    required this.appActivityRepository,
  }) : super(const AppActivityState.initial());

  final inActivityDuration = IN_ACTIVITY_DURATION;
  Timer? _timer;

  Future<void> checkIsVerifiy() async {
    bool isVerify = await appActivityRepository.getIsVerifyPin();
    bool isNewOpening = await appActivityRepository.getIsNewOpening();

    if (!isVerify) {
      _setInActivityState(null);
    } else {
      _startTimer(isReset: isNewOpening);
    }
  }

  Future<void> onVerified() async {
    await appActivityRepository.setIsVerifyPin(true);
    _startTimer(isReset: true);
  }

  Future<void> _startTimer({bool isReset = false}) async {
    String? activityTimer = await appActivityRepository.getActivityTimer();

    if (isReset || activityTimer == null) {
      activityTimer = DateTime.now().toIso8601String();
      appActivityRepository.setActivityTimer(activityTimer: activityTimer);
    }

    final lastActivity = DateTime.parse(activityTimer);
    final now = DateTime.now();
    final differenceFormNow = now.difference(lastActivity);
    int timeOutDuration = inActivityDuration - differenceFormNow.inSeconds;
    if (timeOutDuration > 0) {
      _setActivityState(timeOutDuration);
    } else {
      _setInActivityState(null);
    }
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void resetTimer() {
    _stopTimer();
    _startTimer(isReset: true);
  }

  void _setActivityState(int timeOutDuration) {
    if (_timer != null) _stopTimer();
    _timer =
        Timer.periodic(Duration(seconds: timeOutDuration), _setInActivityState);
    state = state.copyWith(state: AppActivityConcreteState.activity);
  }

  void _setInActivityState(_) {
    _stopTimer();
    appActivityRepository.removeActivityTimer();
    appActivityRepository.setIsVerifyPin(false);
    state = state.copyWith(state: AppActivityConcreteState.inActivity);
  }

  void resetState() {
    _stopTimer();
    state = const AppActivityState.initial();
    appActivityRepository.removeActivityTimer();
    appActivityRepository.setIsVerifyPin(false);
  }
}
