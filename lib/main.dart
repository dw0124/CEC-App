import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:induk/common/repository/token_repository.dart';

import 'package:induk/common/widgets/colors.dart';
import 'package:induk/features/login/login_page.dart';

import 'package:induk/features/notice/repository/notice_repository.dart';
import 'package:induk/features/notice/bloc/notice_bloc.dart';
import 'package:induk/features/notice/view/notice_page.dart';

import 'package:induk/features/rental/repository/rental_repository.dart';
import 'package:induk/features/rental/rental_main/bloc/rental_bloc.dart';
import 'package:induk/features/rental/rental_main/view/rental_page.dart';

import 'package:induk/features/cart/bloc/cart_bloc.dart';
import 'package:induk/features/cart/repository/cart_repository.dart';

import 'package:induk/features/user/presentation/user_main/view/user_page.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: 'assets/config/.env');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late final Future<bool> _initializationFuture;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _initializeAppAndCheckLogin() async {
    final accessToken = await TokenRepository().getAccessToken();
    final isLoggedIn = accessToken.isNotEmpty;

    await Future.delayed(Duration(seconds: 2));

    FlutterNativeSplash.remove();

    return isLoggedIn;
  }

  @override
  void initState() {
    super.initState();

    _initializationFuture = _initializeAppAndCheckLogin();
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      RepositoryProvider(
        create: (context) => RentalRepository(),
        child: BlocProvider(
          create: (context) => RentalBloc(context.read<RentalRepository>()),
          child: const RentalPage(),
        ),
      ),
      RepositoryProvider(
        create: (context) => NoticeRepository(),
        child: BlocProvider(
          create: (context) => NoticeBloc(context.read<NoticeRepository>()),
          child: const NoticePage(),
        ),
      ),
      UserPage()
    ];

    return RepositoryProvider(
      create: (context) => CartRepository(),
      child: BlocProvider(
        create: (context) => CartBloc(context.read<CartRepository>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0
            ),
          ),
          home: FutureBuilder(
              future: _initializationFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                } else {
                  if (snapshot.hasData && snapshot.data == true) {
                    return Scaffold(
                      body: IndexedStack(
                        index: _selectedIndex,
                        children: pages,
                      ),
                      bottomNavigationBar: BottomNavigationBar(
                        items: const <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                              icon: Icon(Icons.home), label: '장비대여'),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.business), label: '공지사항'),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.account_circle_outlined),
                              label: '마이페이지'),
                        ],
                        currentIndex: _selectedIndex,
                        selectedItemColor: AppColors.main,
                        onTap: _onItemTapped,
                      ),
                    );
                  } else {
                    return LoginPage();
                  }
                }
              },
          ),
        ),
      ),
    );
  }
}
