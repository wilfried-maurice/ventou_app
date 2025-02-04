import 'package:flutter/material.dart';
import 'package:ventou/features/detail/detail_screen.dart';
import 'package:ventou/features/home/special_offers_screen.dart';
import 'package:ventou/features/profile/profile_screen.dart';

final Map<String, WidgetBuilder> routes = {
  // HomeScreen.route(): (context) => const HomeScreen(title: '123'),
  // MostPopularScreen.route(): (context) => const MostPopularScreen(),
  SpecialOfferScreen.route(): (context) => const SpecialOfferScreen(),
  ProfileScreen.route(): (context) => const ProfileScreen(),
  ShopDetailScreen.route(): (context) => const ShopDetailScreen(),
  // TestScreen.route(): (context) => const TestScreen(),
};
