import 'package:flutter_project/features/pin_code/presentation/porviders/state/pin_code_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PinCodeState Test\n', () {
    test('Should update concrete state', () {
      PinCodeState taskState = const PinCodeState();

      taskState = taskState.copyWith(message: 'PinCodeConcreteState.loading');

      expect(taskState.message, equals('PinCodeConcreteState.loading'));
    });
    test('Should return valid String', () {
      PinCodeState taskState = const PinCodeState();

      expect(taskState.toString(), '''PinCodeState {
      state: ${taskState.state},
      isLoading: ${taskState.isLoading},
      isPinCorrect: ${taskState.isPinCorrect},
      enteredPin: ${taskState.enteredPin},
      message: ${taskState.message}
    }''');
    });
  });
}
