import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:induk/common/models/equipment.dart';
import 'package:induk/features/rental/rental_apply/bloc/rental_apply_bloc.dart';
import 'package:induk/features/rental/rental_apply/view/rental_apply_page.dart';
import 'package:induk/features/rental/rental_list//view/widget/rental_list_item.dart';
import 'package:induk/features/rental/rental_list/bloc/rental_list_bloc.dart';
import 'package:induk/features/rental/rental_list/bloc/rental_list_event.dart';
import 'package:induk/features/rental/rental_list/bloc/rental_list_state.dart';
import 'package:induk/features/rental/repository/rental_repository.dart';

class RentalListPage extends StatefulWidget {

  const RentalListPage({super.key});

  @override
  State<RentalListPage> createState() => _RentalListPageState();
}

class _RentalListPageState extends State<RentalListPage> with AutomaticKeepAliveClientMixin {
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
          return ListView.separated(
            itemCount: equipmentList.length,
            scrollDirection: Axis.vertical,
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
                        create: (context) => RentalApplyBloc(repository, equipment),
                        child: RentalApplyPage(),
                      ),
                    ),
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
    );
  }
}