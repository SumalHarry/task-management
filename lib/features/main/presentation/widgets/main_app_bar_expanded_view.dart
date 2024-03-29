import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainAppBarExpandedView extends ConsumerWidget {
  const MainAppBarExpandedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text(
            'What are you going to do today?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text(
            'Let\'s get started!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
