// ignore_for_file: constant_identifier_names, use_setters_to_change_properties, avoid_classes_with_only_static_members
enum AppEnvironment { DEV, STAGING, PROD }

abstract class EnvInfo {
  static AppEnvironment _environment = AppEnvironment.DEV;

  static void initialize(AppEnvironment environment) {
    EnvInfo._environment = environment;
  }

  static String get appName => _environment._appTitle;
  static String get envName => _environment._envName;
  static String get connectionString => _environment._connectionString;
  static AppEnvironment get environment => _environment;
  static bool get isProduction => _environment == AppEnvironment.PROD;
}

extension _EnvProperties on AppEnvironment {
  static const _appTitles = {
    AppEnvironment.DEV: 'Task Management Dev',
    AppEnvironment.STAGING: 'Task Management Staging',
    AppEnvironment.PROD: 'Task Management',
  };

  static const _connectionStrings = {
    AppEnvironment.DEV: 'https://todo-list-api-mfchjooefq-as.a.run.app',
    AppEnvironment.STAGING: 'https://todo-list-api-mfchjooefq-as.a.run.app',
    AppEnvironment.PROD: 'https://todo-list-api-mfchjooefq-as.a.run.app',
  };

  static const _envs = {
    AppEnvironment.DEV: 'dev',
    AppEnvironment.STAGING: 'staging',
    AppEnvironment.PROD: 'prod',
  };

  String get _appTitle => _appTitles[this]!;
  String get _envName => _envs[this]!;
  String get _connectionString => _connectionStrings[this]!;
}
