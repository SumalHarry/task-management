import 'package:flutter_project/features/pin_code/domain/repositorys/pin_code_repository.dart';
import 'package:flutter_project/features/pin_code/presentation/porviders/state/pin_code_notifier.dart';
import 'package:flutter_project/features/pin_code/presentation/porviders/state/pin_code_state.dart';
import 'package:flutter_project/shared/domain/models/either.dart';
import 'package:flutter_project/shared/globals.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

import '../../../../fixtures/dummy_data.dart';
import '../../../../fixtures/pin_code/dummy_pin_code.dart';

void main() {
  late PinCodeRepository pinCodeRepository;
  late PinCodeNotifier notifier;
  const pinCode = DEFAULT_CORRECT_PIN;

  setUpAll(() {
    pinCodeRepository = MockPinCodeRepository();
    notifier = PinCodeNotifier(pinCodeRepository);
  });
  stateNotifierTest<PinCodeNotifier, PinCodeState>(
    'Should fail when error occurs on failed',
    build: () => PinCodeNotifier(pinCodeRepository),
    setUp: () {
      when(() => pinCodeRepository.checkPin(pinCode)).thenAnswer(
        (invocation) async => Left(ktestAppException),
      );
    },
    actions: (notifier) async {
      await notifier.checkPin(pinCode);
    },
    expect: () => [
      const PinCodeState(
        state: PinCodeConcreteState.inProgress,
        isLoading: true,
        isPinCorrect: false,
      ),
      const PinCodeState(
        state: PinCodeConcreteState.failure,
        isLoading: false,
        isPinCorrect: false,
      )
    ],
  );

  stateNotifierTest<PinCodeNotifier, PinCodeState>(
    'Should success when occurs on successful with correct pin',
    build: () => PinCodeNotifier(pinCodeRepository),
    setUp: () {
      when(() => pinCodeRepository.checkPin(pinCode)).thenAnswer(
        (invocation) async => Right(ktestPinCodeResponse(true)),
      );
    },
    actions: (notifier) async {
      await notifier.checkPin(pinCode);
    },
    expect: () => [
      const PinCodeState(
        state: PinCodeConcreteState.inProgress,
        isLoading: true,
        isPinCorrect: false,
      ),
      const PinCodeState(
        state: PinCodeConcreteState.success,
        isLoading: false,
        isPinCorrect: true,
      )
    ],
  );
  stateNotifierTest<PinCodeNotifier, PinCodeState>(
    'Should failure when occurs on successful with incorrect pin',
    build: () => PinCodeNotifier(pinCodeRepository),
    setUp: () {
      when(() => pinCodeRepository.checkPin(pinCode)).thenAnswer(
        (invocation) async => Right(ktestPinCodeResponse(false)),
      );
    },
    actions: (notifier) async {
      await notifier.checkPin(pinCode);
    },
    expect: () => [
      const PinCodeState(
        state: PinCodeConcreteState.inProgress,
        isLoading: true,
        isPinCorrect: false,
      ),
      const PinCodeState(
        state: PinCodeConcreteState.failure,
        isLoading: false,
        isPinCorrect: false,
      )
    ],
  );

  stateNotifierTest<PinCodeNotifier, PinCodeState>(
    'Should inProgress and update enteredPin when occurs on successful with add pin number',
    build: () => PinCodeNotifier(pinCodeRepository),
    setUp: () {},
    actions: (notifier) async {
      notifier.addPinNumber(1);
      notifier.addPinNumber(2);
    },
    expect: () => [
      const PinCodeState(
        state: PinCodeConcreteState.inProgress,
        isLoading: false,
        isPinCorrect: false,
        enteredPin: "1",
      ),
      const PinCodeState(
        state: PinCodeConcreteState.inProgress,
        isLoading: false,
        isPinCorrect: false,
        enteredPin: "12",
      ),
    ],
  );

  stateNotifierTest<PinCodeNotifier, PinCodeState>(
    'Should inProgress and update enteredPin when occurs on successful with remove pin number',
    build: () => PinCodeNotifier(pinCodeRepository),
    setUp: () {},
    actions: (notifier) async {
      notifier.addPinNumber(1);
      notifier.addPinNumber(2);
      notifier.removePinNumber();
    },
    expect: () => [
      const PinCodeState(
        state: PinCodeConcreteState.inProgress,
        isLoading: false,
        isPinCorrect: false,
        enteredPin: "1",
      ),
      const PinCodeState(
        state: PinCodeConcreteState.inProgress,
        isLoading: false,
        isPinCorrect: false,
        enteredPin: "12",
      ),
      const PinCodeState(
        state: PinCodeConcreteState.inProgress,
        isLoading: false,
        isPinCorrect: false,
        enteredPin: "1",
      ),
    ],
  );

  test('Should reset state to initial', () {
    notifier.resetState();

    // ignore: invalid_use_of_protected_member
    expect(notifier.state, const PinCodeState.initial());
  });
}

class MockPinCodeRepository extends Mock implements PinCodeRepository {}
