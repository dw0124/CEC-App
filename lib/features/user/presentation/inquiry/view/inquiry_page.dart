import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:induk/common/widgets/app_button.dart';
import 'package:induk/features/user/presentation/inquiry/bloc/Inquiry_bloc.dart';
import 'package:induk/features/user/presentation/inquiry/bloc/Inquiry_event.dart';
import 'package:induk/features/user/presentation/inquiry/bloc/Inquiry_state.dart';
import 'package:induk/features/user/presentation/inquiry/view/inquiry_apply_page.dart';
import 'package:induk/features/user/presentation/inquiry/view/widget/inquiry_list_item.dart';

class InquiryPage extends StatefulWidget {
  const InquiryPage({super.key});

  @override
  State<InquiryPage> createState() => _InquiryPageState();
}

class _InquiryPageState extends State<InquiryPage> {

  @override
  void initState() {
    context.read<InquiryBloc>().add(InquiryListRequest());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '1:1 문의 내역',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child:BlocBuilder<InquiryBloc, InquiryState>(
                builder: (context, state) {
                  return switch (state) {
                    InquiryInitial() => const Center(child: Text('1:1 문의 내역이 없습니다')),
                    InquiryLoading() => const Center(child: CircularProgressIndicator()),
                    InquiryLoaded(:final inquiryList, :final page) => ListView.builder(
                      itemCount: inquiryList.length,
                      itemBuilder: (context, index) {
                        final inquiry = inquiryList[index];
                        return InquiryListItem(inquiry: inquiry);
                      },
                    ),
                    InquiryError(:final message) => Center(child: Text('에러: $message')),
                  };
                },
              )
          ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
        ),
        padding: EdgeInsets.fromLTRB(16, 8, 16, MediaQuery.of(context).padding.bottom),
        child: Row(
          spacing: 16,
          children: [
            Expanded(
                child: AppButton(text: '1:1 문의하기', onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InquiryApplyPage()
                    ),
                  );
                })
            ),
          ],
        ),
      ),
    );
  }
}
