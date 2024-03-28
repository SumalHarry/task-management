abstract class AppActivityRepository {
  Future<bool> setIsVerifyPin(bool IsVerifyPin);
  Future<bool> getIsVerifyPin();
  Future<bool> setActivityTimer({required String activityTimer});
  Future<bool> removeActivityTimer();
  Future<String?> getActivityTimer();
  Future<bool> setIsNewOpening(bool isNewOpening);
  Future<bool> getIsNewOpening();
}
