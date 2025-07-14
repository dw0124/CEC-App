import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:induk/features/rental/rental_list/bloc/rental_list_bloc.dart';
import 'package:induk/features/rental/rental_list/view/rental_list_page.dart';
import 'package:induk/features/rental/repository/rental_repository.dart';

class RentalPage extends StatefulWidget {
  const RentalPage({super.key});

  @override
  State<RentalPage> createState() => _RentalPageState();
}

class _RentalPageState extends State<RentalPage> with SingleTickerProviderStateMixin {
  static const List<Tab> _tabs = <Tab>[
    Tab(text: '카메라'),
    Tab(text: '렌즈'),
    Tab(text: '트라이포드'),
    Tab(text: '배터리'),
    Tab(text: '카메라 부착물'),
    Tab(text: '모니터'),
    Tab(text: '기타장비'),
    Tab(text: '조명'),
    Tab(text: '리더기/SD'),
    Tab(text: '음향'),
  ];

  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: _tabs.length,
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabAlignment: TabAlignment.start,
          indicatorColor: Colors.transparent,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          tabs: _tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(_tabs.length, (index) {
          return BlocProvider(
            create: (context) {
              final repository = context.read<RentalRepository>();
              return RentalListBloc(repository, index + 1);
            },
            child: RentalListPage()
          );
        }),
      ),
    );
  }
}
