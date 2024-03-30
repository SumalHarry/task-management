import 'package:flutter_project/features/pin_code/domain/repositorys/pin_code_repository.dart';
import 'package:flutter_project/features/pin_code/presentation/porviders/state/pin_code_state.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PinCodeNotifier extends StateNotifier<PinCodeState> {
  PinCodeNotifier(this.pinCodeRepository) : super(const PinCodeState.initial());

  final PinCodeRepository pinCodeRepository;

  Future<void> checkPin(String pinCode) async {
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
            isLoading: false,
            isPinCorrect: true,
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

  void addPinNumber(int value) {
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

  void resetState() {
    state = const PinCodeState.initial();
  }
}
