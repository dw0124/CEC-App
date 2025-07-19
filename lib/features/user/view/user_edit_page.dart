import 'package:flutter/material.dart';
import 'package:induk/common/models/user.dart';
import 'package:induk/common/widgets/app_button.dart';

class UserEditPage extends StatefulWidget {
  const UserEditPage({super.key, required this.user});

  final User user;

  @override
  State<UserEditPage> createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  late User user;

  @override
  void initState() {
    user = widget.user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          '회원정보 변경',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
            child: Column(
              spacing: 8,
              children: [
                CircleAvatar(
                  radius: 60.0,
                  //backgroundImage: NetworkImage(user.profilePicture),
                  backgroundColor: Colors.grey,
                ),

                SizedBox(height: 16,),

                Container(
                  height: 32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('이름'),
                      Text(user.name),
                    ],
                  ),
                ),

                //Divider(),

                Container(
                  height: 32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('학번'),
                      Text(user.studentNumber),
                    ],
                  ),
                ),

                //Divider(),

                Container(
                  height: 32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('학과'),
                      Text(user.department),
                    ],
                  ),
                ),

                //Divider(),

                Row(
                  children: [
                    SizedBox(width: 80, child: Text('전화번호')),
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          isDense: true,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87, width: 2),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        ),
                      ),
                    ),
                  ],
                ),

                Spacer(),


                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    text: '수정하기',
                    onPressed: () {
                    },
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
