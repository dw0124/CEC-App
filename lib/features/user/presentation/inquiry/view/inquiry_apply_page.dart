import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:induk/common/widgets/app_button.dart';
import 'package:induk/common/widgets/deletable_image_tile.dart';
import 'package:induk/features/user/model/inquiry.dart';


class InquiryApplyPage extends StatefulWidget {
  const InquiryApplyPage({super.key});

  @override
  State<InquiryApplyPage> createState() => _InquiryApplyPageState();
}

class _InquiryApplyPageState extends State<InquiryApplyPage> {

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  List<XFile> imagePathList = [];

  InquiryType _selectedType = InquiryType.RENTAL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '1:1 문의',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        DropdownButtonFormField<InquiryType>(
                          value: _selectedType,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 12,
                                vertical: 14),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                          ),
                          onChanged: (InquiryType? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedType = newValue;
                              });
                            }
                          },
                          items: InquiryType.values.map((InquiryType type) {
                            return DropdownMenuItem<InquiryType>(
                              value: type,
                              child: Text(type.displayName),
                            );
                          }).toList(),
                        ),


                        // 제목
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('제목'),
                            TextField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5.0)),
                                ),
                                hintText: '제목을 입력해주세요',
                                hintStyle: TextStyle(color: Colors.grey),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 12.0),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5.0)),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5.0)),
                                ),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: 1,
                            ),
                          ],
                        ),

                        // 내용
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('내용'),
                            Container(
                              width: double.infinity,
                              height: 300,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: TextField(
                                controller: _contentController,
                                maxLines: null,
                                expands: true,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '내용을 입력해주세요...',
                                ),
                              ),
                            ),
                            // 또 다른 위젯들...
                          ],
                        ),

                        // 사진
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('사진'),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(
                                      Icons.add_photo_alternate_outlined,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () async {
                                      final ImagePicker picker = ImagePicker();

                                      int currentImageCount = imagePathList.length;
                                      int remainingLimit = 3 - currentImageCount;

                                      if (remainingLimit <= 0) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('최대 3개의 이미지만 선택할 수 있습니다.')),
                                        );
                                        return;
                                      }

                                      List<XFile> newImages = [];
                                      if(remainingLimit == 1) {
                                        final newImage = await picker.pickImage(source: ImageSource.gallery);
                                        newImages.add(newImage!);
                                      } else {
                                        newImages = await picker.pickMultiImage(limit: remainingLimit);
                                      }


                                      if (newImages.isNotEmpty) {
                                        setState(() {
                                            imagePathList = [...imagePathList, ...newImages];
                                        });
                                      }
                                    },
                                    tooltip: '사진 선택',
                                  ),
                                ),
                                const SizedBox(
                                  height: 60,
                                  child: VerticalDivider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                ),

                                Expanded(
                                  child: Container(
                                    height: 110,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: imagePathList.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        final imageFile = imagePathList[index];
                                        return DeletableImageTile(
                                            imagePath: imageFile.path,
                                            onDelete: () {
                                              setState(() {
                                                imagePathList.removeAt(index);
                                              });
                                            }
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),

                        SizedBox(height: 8,)
                      ],
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  child: AppButton(
                      text: '문의하기',
                      onPressed: () {}
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
