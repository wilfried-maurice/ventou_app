import 'package:flutter/material.dart';
import 'package:ventou/core/constants/constants.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            // onTap: () => Navigator.pushNamed(context, ProfileScreen.route()),
            child: const CircleAvatar(
              backgroundImage: AssetImage('$kIconPath/me.png'),
              radius: 20,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Morning 👋',
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Mansuriosdev',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            iconSize: 8,
            icon: Image.asset(
              '$kIconPath/notification.png',
              width: 25,
              height: 25,
            ),
            onPressed: () {},
          ),
          // IconButton(
          //   iconSize: 28,
          //   icon: Image.asset(
          //     '$kIconPath/light/heart@2x.png',
          //     width: 25,
          //     height: 25,
          //   ),
          //   onPressed: () {},
          // ),
        ],
      ),
    );
  }
}
