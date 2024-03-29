import 'dart:io';

final kTestMode = Platform.environment.containsKey('FLUTTER_TEST');

const int PIN_LENGTH = 6;
const int ITEMS_PER_PAGE = 10;
const String CREATE_AT = "createdAt";

const int IN_ACTIVITY_DURATION = 10;
const String APP_THEME_STORAGE_KEY = 'APP_THEME_STORAGE_KEY';

const String APP_ACTIVITY_LOCAL_STORAGE_KEY_IS_NEW_OPENING =
    'APP_ACTIVITY_LOCAL_STORAGE_KEY_IS_NEW_OPENING';
const String APP_ACTIVITY_LOCAL_STORAGE_KEY_IS_VERIFY_PIN =
    'APP_ACTIVITY_LOCAL_STORAGE_KEY_IS_VERIFY_PIN';
const String APP_ACTIVITY_LOCAL_STORAGE_KEY_ACTIVITY_TIMER =
    'APP_ACTIVITY_LOCAL_STORAGE_KEY_ACTIVITY_TIMER';
