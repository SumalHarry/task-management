import 'package:equatable/equatable.dart';

enum PinCodeConcreteState {
  initial,
  inProgress,
  success,
  failure,
}

class PinCodeState extends Equatable {
  final PinCodeConcreteState state;
  final bool isLoading;
  final bool isPinCorrect;
  final String enteredPin;
  final String message;

  const PinCodeState({
    this.state = PinCodeConcreteState.initial,
    this.isLoading = false,
    this.isPinCorrect = false,
    this.enteredPin = '',
    this.message = '',
  });

  const PinCodeState.initial({
    this.state = PinCodeConcreteState.initial,
    this.isLoading = false,
    this.isPinCorrect = false,
    this.enteredPin = '',
    this.message = '',
  });

  PinCodeState copyWith({
    PinCodeConcreteState? state,
    bool? isLoading,
    bool? isPinCorrect,
    String? enteredPin,
    String? message,
  }) {
    return PinCodeState(
      isLoading: isLoading ?? this.isLoading,
      state: state ?? this.state,
      isPinCorrect: isPinCorrect ?? this.isPinCorrect,
      enteredPin: enteredPin ?? this.enteredPin,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return '''PinCodeState {
      state: $state,
      isLoading: $isLoading,
      isPinCorrect: $isPinCorrect,
      enteredPin: $enteredPin,
      message: $message
    }''';
  }

  @override
  List<Object?> get props => [state, isLoading, isPinCorrect, enteredPin];
}
