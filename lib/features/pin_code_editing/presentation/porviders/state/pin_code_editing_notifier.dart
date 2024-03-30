import 'package:flutter_project/features/pin_code/domain/repositorys/pin_code_repository.dart';
import 'package:flutter_project/features/pin_code/presentation/porviders/state/pin_code_state.dart';
import 'package:flutter_project/features/pin_code_editing/presentation/porviders/state/pin_code_editing_state.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PinCodeEditingNotifier extends StateNotifier<PinCodeEditingState> {
  PinCodeEditingNotifier(
    this.pinCodeRepository,
  ) : super(const PinCodeEditingState.initial());

  final PinCodeRepository pinCodeRepository;

  Future<void> checkPin(String pinCode) async {
    switch (state.editingState) {
      case PinCodeEditingConcreteState.confirmCurrentPin:
        _confirmOldPin(pinCode);
      case PinCodeEditingConcreteState.newPin:
        _newPin(pinCode);
      case PinCodeEditingConcreteState.confirmNewPin:
        _confirmNewPin(pinCode);
      default:
        break;
    }
  }

  Future<void> _confirmOldPin(String pinCode) async {
    state =
        state.copyWith(isLoading: true, state: PinCodeConcreteState.inProgress);
    final response = await pinCodeRepository.checkPin(pinCode);
    state = await response.fold(
      (failure) async {
        return state.copyWith(
            state: PinCodeConcreteState.failure,
            isLoading: false,
            message: failure.message);
      },
      (isPinCorrect) async {
        if (isPinCorrect) {
          return state.copyWith(
            state: PinCodeConcreteState.success,
            editingState: PinCodeEditingConcreteState.newPin,
            isLoading: false,
            isPinCorrect: true,
            enteredPin: '',
            enteredNewPin: '',
          );
        } else {
          return state.copyWith(
            state: PinCodeConcreteState.failure,
            isLoading: false,
            message: 'Pin is incorrect',
            enteredPin: '',
          );
        }
      },
    );
  }

  void _newPin(String pinCode) {
    state = state.copyWith(
      state: PinCodeConcreteState.success,
      editingState: PinCodeEditingConcreteState.confirmNewPin,
      isLoading: false,
      enteredPin: '',
      enteredNewPin: pinCode,
    );
  }

  Future<void> _confirmNewPin(pinCode) async {
    if (state.enteredNewPin == pinCode) {
      final response =
          await pinCodeRepository.setCorrectPinCode(newPinCode: pinCode);
      state = await response.fold(
        (failure) async {
          return state.copyWith(
              state: PinCodeConcreteState.failure,
              isLoading: false,
              message: failure.message);
        },
        (_) async {
          return state.copyWith(
            state: PinCodeConcreteState.success,
            editingState: PinCodeEditingConcreteState.success,
            isLoading: false,
          );
        },
      );
    } else {
      state = state.copyWith(
        state: PinCodeConcreteState.failure,
        isLoading: false,
        message: 'Confirm pin is not match',
        enteredPin: '',
      );
    }
  }

  void addPinNumber(
    int value,
  ) {
    if (state.enteredPin.length < PIN_LENGTH) {
      state = state.copyWith(
        state: PinCodeConcreteState.inProgress,
        enteredPin: state.enteredPin + value.toString(),
      );
    }

    if (state.enteredPin.length == PIN_LENGTH) {
      checkPin(state.enteredPin);
    }
  }

  void removePinNumber() {
    if (state.enteredPin.isNotEmpty) {
      state = state.copyWith(
        state: PinCodeConcreteState.inProgress,
        enteredPin: state.enteredPin.substring(0, state.enteredPin.length - 1),
      );
    }
  }

  void setupEditingState(
    PinCodeEditingConcreteState editingState,
  ) async {
    state = state.copyWith(
      editingState: editingState,
    );
  }

  void resetState() {
    state = const PinCodeEditingState.initial();
  }
}
