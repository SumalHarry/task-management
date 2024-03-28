import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/features/pin_code/presentation/porviders/pin_code_providers.dart';
import 'package:flutter_project/features/pin_code/presentation/porviders/state/pin_code_state.dart';
import 'package:flutter_project/features/pin_code/presentation/screens/pin_code_screen.dart';
import 'package:flutter_project/shared/domain/models/task/task_status.dart';
import 'package:flutter_project/features/task/presentation/widgets/task_list.dart';
import 'package:flutter_project/shared/widgets/app_activity/presentation/providers/app_activity_state_providers.dart';
import 'package:flutter_project/shared/widgets/app_activity/presentation/widgets/app_activity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class MainScreen extends ConsumerStatefulWidget {
  static const routeName = '/mainScreen';

  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<TaskStatus> tabStatus = [
    TaskStatus.TODO,
    TaskStatus.DOING,
    TaskStatus.DONE
  ];

  @override
  void initState() {
    _tabController = TabController(
      length: tabStatus.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppActivity(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                surfaceTintColor: Colors.purple,
                backgroundColor: Colors.purple,
                stretch: false,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notification_add,
                      color: Color.fromARGB(255, 255, 157, 0),
                      size: 30.0,
                    ),
                  ),
                ],
                pinned: true,
                expandedHeight: 150.0,
                centerTitle: false,
                title: const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text('Hi, User'),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Colors.purple,
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  TabBar.secondary(
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.grey,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: const TextStyle(fontWeight: FontWeight.w700),
                    labelColor: Colors.white,
                    controller: _tabController,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    indicator: BoxDecoration(
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1.0,
                          offset: Offset(
                            1.0,
                            1.0,
                          ),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: const LinearGradient(
                        colors: [
                          Colors.grey,
                          Colors.blue,
                        ],
                      ),
                    ),
                    tabs: List.generate(
                      tabStatus.length,
                      (index) => Tab(
                        text: tabStatus[index].title,
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: SafeArea(
            top: false,
            child: TabBarView(
              controller: _tabController,
              children: List.generate(
                tabStatus.length,
                (index) => TaskList(
                  taskStatus: tabStatus[index],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.deepOrange],
            ),
          ),
          child: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: Colors.transparent,
            child: const Icon(Icons.add),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => 60;
  @override
  double get maxExtent => 60;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(children: [
      Positioned(
        child: Container(
          height: 30,
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30),
          ),
          child: _tabBar,
        ),
      ),
    ]);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
