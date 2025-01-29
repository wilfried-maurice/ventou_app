import 'package:flutter/material.dart';
import 'package:ventou/core/constants/image_loader.dart';
import 'package:ventou/core/constants/size_config.dart';
import 'package:ventou/features/profile/profile_screen.dart';
import 'package:ventou/features/home/home_view.dart';

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
    const ProfileScreen(),
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
      label: 'Accueil',
    ),
    BottomNavigationBarItem(
      icon: generateIcon('light/Bag@2x.png'),
      activeIcon: generateIcon('bold/Bag@2x.png'),
      label: 'Favoris',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.add_circle, size: 42, color: Colors.orange),
    //   label: '',
    // ),
    BottomNavigationBarItem(
      icon: generateIcon('light/Buy@2x.png'),
      activeIcon: generateIcon('bold/Buy@2x.png'),
      label: 'Orders',
    ),
    BottomNavigationBarItem(
      icon: generateIcon('light/Profile@2x.png'),
      activeIcon: generateIcon('bold/Profile@2x.png'),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: screens[_select],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          // Ajoute ici l'action du bouton Add
        },
        child: const Icon(Icons.add, size: 25, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BottomNavigationBar(
            items: items,
            onTap: ((value) {
              if (value != 2) {
                // Empêche de sélectionner le bouton Add
                setState(() => _select = value);
              }
            }),
            currentIndex: _select,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
            showUnselectedLabels: true,
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 10,
            ),
            selectedItemColor: const Color(0xFF212121),
            unselectedItemColor: const Color(0xFF9E9E9E),
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
