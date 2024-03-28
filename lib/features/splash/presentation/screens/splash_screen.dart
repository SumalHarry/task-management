import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/routes/app_route.dart';
import 'package:flutter_project/shared/widgets/app_activity/domain/providers/app_activity_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SplashScreen extends ConsumerStatefulWidget {
  static const String routeName = '/splashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final AppRouter appRouter = AppRouter();
  @override
  void initState() {
    super.initState();

    ref.read(appActivityRepositoryProvider).setIsNewOpening(true);
    Future.delayed(const Duration(seconds: 2), () async {
      AutoRouter.of(context).pushAndPopUntil(
        const MainRoute(),
        predicate: (_) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Center(
        child: Text(
          'Splash Screen',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
