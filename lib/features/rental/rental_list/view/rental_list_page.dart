import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:induk/common/models/equipment.dart';
import 'package:induk/features/rental/rental_apply/bloc/rental_apply_bloc.dart';
import 'package:induk/features/rental/rental_apply/view/rental_apply_page.dart';
import 'package:induk/features/rental/rental_list//view/widget/rental_list_item.dart';
import 'package:induk/features/rental/rental_list/bloc/rental_list_bloc.dart';
import 'package:induk/features/rental/rental_list/bloc/rental_list_event.dart';
import 'package:induk/features/rental/rental_list/bloc/rental_list_state.dart';
import 'package:induk/features/rental/rental_list/view/widget/rental_grid_item.dart';
import 'package:induk/features/rental/repository/rental_repository.dart';

class RentalListPage extends StatefulWidget {

  const RentalListPage({super.key});

  @override
  State<RentalListPage> createState() => _RentalListPageState();
}

class _RentalListPageState extends State<RentalListPage> with AutomaticKeepAliveClientMixin {
  int _crossAxisCount = 3;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    final categoryId = context.read<RentalListBloc>().state.categoryId;
    context.read<RentalListBloc>().add(RentalItemListFetch());

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocSelector<RentalListBloc, RentalListState, List<Equipment>>(
      selector: (state) => state.rentalItemList,
      builder: (context, equipmentList) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey, // border 색상
                      width: 0.6,         // border 두께
                    ),
                  ),
                ),
                height: 48,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text('18개'),
                    Spacer(),
                    CupertinoSegmentedControl(
                        groupValue: _crossAxisCount,
                        unselectedColor: Colors.white,
                        selectedColor: Colors.grey[800],
                        borderColor: Colors.white,
                        children: {
                          1: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(Icons.reorder_rounded, size: 24),
                          ),
                          2: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(Icons.grid_view_rounded, size: 24),
                          ),
                          3: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(Icons.apps, size: 24),
                          ),
                        },
                        onValueChanged: (index) {
                          setState(() {
                            _crossAxisCount = index;
                          });
                        }
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: _crossAxisCount == 1
                  ? SliverList.separated(
                itemBuilder: (context, index) {
                  final equipment = equipmentList[index];

                  return RentalListItem(
                    key: ValueKey(equipment.id),
                    equipment: equipment,
                    onTap: () {
                      final repository = context.read<RentalRepository>();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) =>
                                RentalApplyBloc(repository, equipment),
                            child: RentalApplyPage(),
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.black.withOpacity(0.3),
                    height: 12,
                  );
                },
                itemCount: equipmentList.length,
              )
                  : SliverGrid.builder(
                  itemCount: equipmentList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      crossAxisCount: _crossAxisCount,
                      childAspectRatio: _crossAxisCount == 2 ? 0.8 : 0.6
                  ),
                  itemBuilder: (context, index) {
                    final equipment = equipmentList[index];

                    return RentalGridItem(
                        key: ValueKey(equipment.id),
                        equipment: equipment,
                        onTap: () {
                          final repository = context.read<RentalRepository>();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    RentalApplyBloc(repository, equipment),
                                child: RentalApplyPage(),
                              ),
                            ),
                          );
                        }
                    );
                  }
                ),
            ),
          ],
        );
      },
    );
  }
}