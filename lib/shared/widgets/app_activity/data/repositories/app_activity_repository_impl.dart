import 'package:flutter_project/shared/widgets/app_activity/data/datasource/app_activity_local_datesource.dart';
import 'package:flutter_project/shared/widgets/app_activity/domain/repositories/app_activity_repository.dart';

class AppActivityRepositoryImpl extends AppActivityRepository {
  AppActivityRepositoryImpl(this.dataSource);

  final AppActivityDataSource dataSource;

  @override
  Future<bool> setIsVerifyPin(bool IsVerifyPin) {
    return dataSource.setIsVerifyPin(IsVerifyPin: IsVerifyPin);
  }

  @override
  Future<bool> getIsVerifyPin() {
    return dataSource.getIsVerifyPin();
  }

  @override
  Future<bool> setActivityTimer({required String activityTimer}) {
    return dataSource.setActivityTimer(activityTimer: activityTimer);
  }

  @override
  Future<bool> removeActivityTimer() {
    return dataSource.removeActivityTimer();
  }

  @override
  Future<String?> getActivityTimer() {
    return dataSource.getActivityTimer();
  }

  @override
  Future<bool> setIsNewOpening(bool isNewOpening) {
    return dataSource.setIsNewOpening(isNewOpening: isNewOpening);
  }

  @override
  Future<bool> getIsNewOpening() {
    return dataSource.getIsNewOpening();
  }
}
