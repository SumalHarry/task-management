import 'package:flutter_project/features/pin_code/domain/providers/pin_code_provider.dart';
import 'package:flutter_project/features/pin_code/domain/repositorys/pin_code_repository.dart';
import 'package:flutter_project/features/pin_code/presentation/porviders/state/pin_code_notifier.dart';
import 'package:flutter_project/features/pin_code/presentation/porviders/state/pin_code_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pinCodeNotifierProvider =
    StateNotifierProvider<PinCodeNotifier, PinCodeState>((ref) {
  final PinCodeRepository pinCodeRepository =
      ref.watch(pinCodeRepositoryProvider);

  return PinCodeNotifier(
    pinCodeRepository: pinCodeRepository,
  );
});
