import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:induk/common/models/equipment.dart';
import 'package:induk/features/rental/bloc/rental_bloc.dart';
import 'package:induk/features/rental/bloc/rental_event.dart';
import 'package:induk/features/rental/bloc/rental_state.dart';
import 'package:induk/features/rental/view/rental_apply_page.dart';
import 'package:induk/features/rental/view/widget/rental_list_item.dart';

class RentalListPage extends StatefulWidget {
  final int categoryId;

  const RentalListPage({super.key, required this.categoryId});

  @override
  State<RentalListPage> createState() => _RentalListPageState();
}

class _RentalListPageState extends State<RentalListPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    context.read<RentalBloc>().add(RentalItemListFetch(categoryId: widget.categoryId));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocSelector<RentalBloc, RentalState, List<Equipment>?>(
        selector: (state) => state.rentalItemList[widget.categoryId],
        builder: (context, equipmentList) {
          if (equipmentList == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.separated(
              itemCount: equipmentList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final equipment = equipmentList[index];

                return RentalListItem(
                  key: ValueKey(equipment.id),
                  equipment: equipment,
                  onTap: () {
                    final rentalApplyPage = RentalApplyPage(
                        equipment: equipment);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => rentalApplyPage,
                        )
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(
                    color: Colors.black.withValues(alpha: 0.3),
                    height: 12,
                  ),
            );
          }
        }
    );
  }
}