import 'package:equatable/equatable.dart';

enum AppActivityConcreteState {
  initial,
  activity,
  inActivity,
}

class AppActivityState extends Equatable {
  final AppActivityConcreteState state;

  const AppActivityState({
    this.state = AppActivityConcreteState.initial,
  });

  const AppActivityState.initial({
    this.state = AppActivityConcreteState.initial,
  });

  AppActivityState copyWith({
    AppActivityConcreteState? state,
  }) {
    return AppActivityState(
      state: state ?? this.state,
    );
  }

  @override
  String toString() {
    return 'AppActivityState(state: $state)';
  }

  @override
  List<Object?> get props => [state];
}
