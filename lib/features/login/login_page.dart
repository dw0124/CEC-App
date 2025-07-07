import 'package:flutter/material.dart';
import 'package:induk/features/login/login_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _idTextController = TextEditingController();
  final _pwTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _idTextController.dispose();
    _pwTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("assets/images/induk_logo.png"),

              SizedBox(height: 32,),

              Text(
                "로그인",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                ),
              ),

              //Spacer(),
              SizedBox(height: 32,),

              TextField(
                decoration: InputDecoration(
                  hintText: "학번",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                controller: _idTextController,
              ),

              SizedBox(height: 16,),

              TextField(
                decoration: InputDecoration(
                  hintText: "비밀번호",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                controller: _pwTextController,
              ),


              SizedBox(height: 16,),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    final id = _idTextController.text;
                    final pwd = _pwTextController.text;
                    final result = await LoginRepository().login(id: id, pwd: pwd);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6), // 모서리 둥글기
                    ),
                    backgroundColor: Color(0xFF8A1E35), // 배경색
                    foregroundColor: Colors.white,  // 텍스트 색
                  ),
                  child: Text(
                      "로그인",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  )
                ),
              ),

              SizedBox(height: 4),

              TextButton(
                  onPressed: () {},
                  child: Text(
                      "비밀번호 찾기",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: Colors.black
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
