import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/features/main_screen/presentation/screen/main_screen.dart';
import 'package:flutter_project/features/pin_code/presentation/screens/pin_code_screen.dart';
import 'package:flutter_project/features/pin_code_editing/presentation/screens/pin_code_editing_screen.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
part 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType =>
      const RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: MainRoute.page),
        AutoRoute(page: PinCodeRoute.page),
        AutoRoute(page: PinCodeEditingRoute.page),
      ];
}
