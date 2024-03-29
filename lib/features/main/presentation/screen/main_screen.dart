import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/features/main/presentation/widgets/main_app_bar_expanded_view.dart';
import 'package:flutter_project/shared/domain/models/task/task_status.dart';
import 'package:flutter_project/features/task/presentation/widgets/task_list.dart';
import 'package:flutter_project/shared/theme/app_colors.dart';
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
  final ScrollController _scrollController = ScrollController();

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
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      _scrollToTop();
    }
  }

  _scrollToTop() {
    _scrollController.animateTo(
      100.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration decorationLinearGradient = BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.secondary,
          Theme.of(context).primaryColor,
        ],
      ),
    );

    return AppActivity(
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: const Text(
                    'Hi, User',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                elevation: 10,
                expandedHeight: 150.0,
                centerTitle: false,
                pinned: true,
                surfaceTintColor: Colors.transparent,
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
                flexibleSpace: DecoratedBox(
                  decoration: decorationLinearGradient,
                  child: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Container(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      decoration: decorationLinearGradient,
                      child: const MainAppBarExpandedView(),
                    ),
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
                    padding: const EdgeInsets.all(10),
                    indicator: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1.0,
                          offset: Offset(
                            1.0,
                            1.0,
                          ),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.secondary,
                          Theme.of(context).primaryColor,
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
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColors.secondary,
                Theme.of(context).primaryColor,
              ],
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
            gradient: LinearGradient(
              colors: [
                AppColors.secondary,
                Theme.of(context).primaryColor,
              ],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
      ),
      SafeArea(
        top: false,
        bottom: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30),
            ),
            child: _tabBar,
          ),
        ),
      ),
    ]);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
