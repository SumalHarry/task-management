import 'package:flutter_project/features/pin_code/presentation/porviders/state/pin_code_state.dart';

enum PinCodeEditingConcreteState {
  initial,
  confirmOldPin,
  newPin,
  confirmNewPin,
  success,
}

extension PinCodeEditingConcreteStateGetter on PinCodeEditingConcreteState {
  String get title {
    switch (this) {
      case PinCodeEditingConcreteState.confirmOldPin:
        return 'Confirm Old pin code';
      case PinCodeEditingConcreteState.newPin:
        return 'Enter New pin code';
      case PinCodeEditingConcreteState.confirmNewPin:
        return 'Confirm new pin code';
      default:
        return '';
    }
  }
}

class PinCodeEditingState {
  final PinCodeConcreteState state;
  final bool isLoading;
  final bool isPinCorrect;
  final String enteredPin;
  final String enteredNewPin;
  final String message;
  final PinCodeEditingConcreteState editingState;

  const PinCodeEditingState({
    this.state = PinCodeConcreteState.initial,
    this.isLoading = false,
    this.isPinCorrect = false,
    this.enteredPin = '',
    this.enteredNewPin = '',
    this.message = '',
    this.editingState = PinCodeEditingConcreteState.initial,
  });

  const PinCodeEditingState.initial({
    this.state = PinCodeConcreteState.initial,
    this.isLoading = false,
    this.isPinCorrect = false,
    this.enteredPin = '',
    this.enteredNewPin = '',
    this.message = '',
    this.editingState = PinCodeEditingConcreteState.initial,
  });

  PinCodeEditingState copyWith({
    PinCodeConcreteState? state,
    PinCodeEditingConcreteState? editingState,
    bool? isLoading,
    bool? isPinCorrect,
    String? enteredPin,
    String? enteredNewPin,
    String? message,
  }) {
    return PinCodeEditingState(
      isLoading: isLoading ?? this.isLoading,
      state: state ?? this.state,
      isPinCorrect: isPinCorrect ?? this.isPinCorrect,
      enteredPin: enteredPin ?? this.enteredPin,
      enteredNewPin: enteredNewPin ?? this.enteredNewPin,
      message: message ?? this.message,
      editingState: editingState ?? this.editingState,
    );
  }

  @override
  String toString() {
    return '''PinCodeEditingState {
      state: $state,
      editingState: $editingState,
      isLoading: $isLoading,
      enteredPin: $enteredPin,
      enteredNewPin: $enteredNewPin,
      message: $message
    }''';
  }

  List<Object?> get props => [
        state,
        isLoading,
        enteredPin,
        enteredNewPin,
        editingState,
      ];

  bool? get stringify => throw UnimplementedError();
}
