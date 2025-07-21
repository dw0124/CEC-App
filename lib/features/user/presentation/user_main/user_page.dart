import 'package:flutter/material.dart';
import 'package:induk/common/models/user.dart';
import 'package:induk/features/user/presentation/user_edit/view/user_edit_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late User user;

  @override
  void initState() {
    user = User(
      id: 1,
      studentNumber: '202312345',
      name: '홍길동',
      nickname: '닉네임',
      role: '학생',
      department: '컴퓨터소프트웨어학과',
      profilePicture: 'https://example.com/profile.jpg', // 혹은 null
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          '마이페이지',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
              children: [

                // 1. 유저 정보 - 이미지, 이름, 학번
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    final userEditPage = UserEditPage(user: user);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => userEditPage,
                        )
                    );
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        //backgroundImage: NetworkImage(user.profilePicture),
                        backgroundColor: Colors.grey,
                      ),
                      SizedBox(width: 8,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                user.nickname,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "[${user.role}]",
                                style: TextStyle(),
                              ),
                            ],
                          ),

                          Text(
                            user.studentNumber,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                          ),
                        ],
                      )
                    ],
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),

                SizedBox(height: 12,),


                Column(
                    children: [
                      Divider(),

                      // 2. 대여 내역
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Text('대여 내역', style: TextStyle(fontSize: 16),),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {},
                      ),

                      Divider(),

                      // 3. 1:1 문의, FAQ, 공지사항
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Text('1:1 문의', style: TextStyle(fontSize: 16),),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {},
                      ),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Text('FAQ', style: TextStyle(fontSize: 16),),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {},
                      ),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Text('공지사항', style: TextStyle(fontSize: 16),),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {},
                      ),

                      Divider(),
                    ],
                ),

                Spacer(),

                // 로그 아웃
                TextButton(
                    onPressed: () {},
                    child: Text(
                        '로그아웃',
                      style: TextStyle(color: Colors.grey.shade500),
                    )
                ),
              ]
          ),
        ),
      ),
    );
  }
}
