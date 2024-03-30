import 'package:flutter_project/features/pin_code/domain/providers/pin_code_provider.dart';
import 'package:flutter_project/features/pin_code/domain/repositorys/pin_code_repository.dart';
import 'package:flutter_project/features/pin_code_editing/presentation/porviders/state/pin_code_editing_notifier.dart';
import 'package:flutter_project/features/pin_code_editing/presentation/porviders/state/pin_code_editing_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pinCodeEditingNotifierProvider =
    StateNotifierProvider<PinCodeEditingNotifier, PinCodeEditingState>((ref) {
  final PinCodeRepository pinCodeRepository =
      ref.watch(pinCodeRepositoryProvider);

  return PinCodeEditingNotifier(
    pinCodeRepository,
  );
});
