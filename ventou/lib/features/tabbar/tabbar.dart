import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:ventou/core/constants/image_loader.dart';
import 'package:ventou/core/constants/size_config.dart';
import 'package:ventou/features/bloc/create_post_bloc/create_post_bloc.dart';
import 'package:ventou/features/bloc/my_user_bloc/my_user_bloc.dart';
import 'package:ventou/features/home/post_screen.dart';
import 'package:ventou/features/profile/profile_screen.dart';
import 'package:ventou/features/home/home_view.dart';
import 'package:ventou/features/settings/view/settings_view.dart';
import 'package:ventou/features/theme/bloc/theme_bloc.dart';
import 'package:ventou/features/theme/bloc/theme_state.dart';
import 'package:ventou/generated/locale_keys.g.dart';

class TabbarItem {
  final String lightIcon;
  final String boldIcon;
  final String label;

  TabbarItem(
      {required this.lightIcon, required this.boldIcon, required this.label});

  BottomNavigationBarItem item(bool isbold) {
    return BottomNavigationBarItem(
      icon: ImageLoader.imageAsset(isbold ? boldIcon : lightIcon),
      label: label,
    );
  }

  BottomNavigationBarItem get light => item(false);
  BottomNavigationBarItem get bold => item(true);
}

class FRTabbarScreen extends StatefulWidget {
  const FRTabbarScreen({super.key});

  @override
  State<FRTabbarScreen> createState() => _FRTabbarScreenState();
}

class _FRTabbarScreenState extends State<FRTabbarScreen> {
  int _select = 0;

  final screens = [
    const HomeView(title: 'Hello'),
    const ProfileScreen(),
    const ProfileScreen(),
    const SettingsView(),
  ];

  static Image generateIcon(String path) {
    return Image.asset(
      '${ImageLoader.rootPaht}/tabbar/$path',
      width: 24,
      height: 24,
    );
  }

  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: generateIcon('light/Home@2x.png'),
      activeIcon: generateIcon('bold/Home@2x.png'),
      label: LocaleKeys.accueil.tr(),
    ),
    BottomNavigationBarItem(
      icon: generateIcon('light/Bag@2x.png'),
      activeIcon: generateIcon('bold/Bag@2x.png'),
      label: LocaleKeys.favoris.tr(),
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.add_circle, size: 42, color: Colors.orange),
    //   label: '',
    // ),
    BottomNavigationBarItem(
      icon: generateIcon('light/Buy@2x.png'),
      activeIcon: generateIcon('bold/Buy@2x.png'),
      label: LocaleKeys.orders.tr(),
    ),
    BottomNavigationBarItem(
      icon: generateIcon('light/Profile@2x.png'),
      activeIcon: generateIcon('bold/Profile@2x.png'),
      label: LocaleKeys.profile.tr(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: screens[_select],
      floatingActionButton: BlocBuilder<MyUserBloc, MyUserState>(
        builder: (context, state) {
          if (state.status == MyUserStatus.success) {
            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, statetheme) {
                return FloatingActionButton(
                  backgroundColor: Color(0xFF361d32),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            BlocProvider<CreatePostBloc>(
                          create: (context) => CreatePostBloc(
                            postRepository: FirebasePostRepository(),
                          ),
                          child: PostScreen(state.user!),
                        ),
                      ),
                    );
                  },
                  child: const Icon(CupertinoIcons.add,
                      size: 25, color: Colors.white),
                );
              },
            );
          } else {
            return const FloatingActionButton(
              onPressed: null,
              child: Icon(CupertinoIcons.clear),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BottomNavigationBar(
            mouseCursor: MouseCursor.defer,
            elevation: 1,
            backgroundColor: Color(0XFFf1e8e6),
            items: items,
            onTap: ((value) {
              if (value != 4) {
                // Empêche de sélectionner le bouton Add
                setState(() => _select = value);
              }
            }),
            currentIndex: _select,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 10,
            ),
            showUnselectedLabels: true,
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
            selectedItemColor: const Color(0xFF361d32),
            unselectedItemColor: const Color(0xFF2E384D),
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
