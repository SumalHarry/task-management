class AppActivityModel {
  final String? activityTimer;
  final bool? isVerifyPin;
  const AppActivityModel({
    this.activityTimer,
    this.isVerifyPin,
  });

  AppActivityModel copyWith({
    String? activityTimer,
    bool? isVerifyPin,
    bool? isNewOpening,
  }) {
    return AppActivityModel(
      activityTimer: activityTimer ?? this.activityTimer,
      isVerifyPin: isVerifyPin ?? this.isVerifyPin,
    );
  }
}
