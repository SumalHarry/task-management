import 'package:flutter_project/shared/data/local/storage_service.dart';
import 'package:flutter_project/shared/globals.dart';

abstract class AppActivityDataSource {
  String get storageKeyIsVerifyPin;
  String get storageKeyActivityTimer;
  String get storageKeyIsNewOpeing;

  Future<bool> setIsVerifyPin({required bool IsVerifyPin});
  Future<bool> getIsVerifyPin();
  Future<bool> setActivityTimer({required String activityTimer});
  Future<bool> removeActivityTimer();
  Future<String?> getActivityTimer();
  Future<bool> setIsNewOpening({required bool isNewOpening});
  Future<bool> getIsNewOpening();
}

class AppActivityLocalDatasource extends AppActivityDataSource {
  AppActivityLocalDatasource(this.storageService);

  final StorageService storageService;

  @override
  String get storageKeyIsVerifyPin =>
      APP_ACTIVITY_LOCAL_STORAGE_KEY_IS_VERIFY_PIN;
  @override
  String get storageKeyActivityTimer =>
      APP_ACTIVITY_LOCAL_STORAGE_KEY_ACTIVITY_TIMER;

  @override
  String get storageKeyIsNewOpeing =>
      APP_ACTIVITY_LOCAL_STORAGE_KEY_IS_NEW_OPENING;

  @override
  Future<bool> setIsVerifyPin({required bool IsVerifyPin}) async {
    return await storageService.set(
        storageKeyIsVerifyPin, IsVerifyPin.toString());
  }

  @override
  Future<bool> getIsVerifyPin() async {
    final data = await storageService.get(storageKeyIsVerifyPin);
    return data != null ? data.toString().toLowerCase() == 'true' : false;
  }

  @override
  Future<bool> setActivityTimer({required String activityTimer}) async {
    return await storageService.set(storageKeyActivityTimer, activityTimer);
  }

  @override
  Future<bool> removeActivityTimer() async {
    return await storageService.remove(storageKeyActivityTimer);
  }

  @override
  Future<String?> getActivityTimer() async {
    final data = await storageService.get(storageKeyActivityTimer);
    return data?.toString();
  }

  @override
  Future<bool> setIsNewOpening({required bool isNewOpening}) async {
    return await storageService.set(
        storageKeyIsNewOpeing, isNewOpening.toString());
  }

  @override
  Future<bool> getIsNewOpening() async {
    final data = await storageService.get(storageKeyIsNewOpeing);
    setIsNewOpening(isNewOpening: false);
    return data != null ? data.toString().toLowerCase() == 'true' : true;
  }
}
